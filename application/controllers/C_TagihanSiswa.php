<?php 
	class C_TagihanSiswa extends CI_Controller {
		private $table = 'tsiswa';

		function __construct()
		{
			parent::__construct();
			$this->load->model('ModelsExecuteMaster');
			$this->load->model('GlobalVar');
			$this->load->model('LoginMod');
		}

		public function ReadHeader()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());
			$FromDate = $this->input->post('FromDate');
			$ToDate = $this->input->post('ToDate');
			$Kelas = $this->input->post('Kelas');
			$Jurusan = $this->input->post('Jurusan');
			$Status = $this->input->post('Status');
			$textSearch = $this->input->post('textSearch');
			$NIS = $this->input->post('NIS');

			$SQL = "SELECT * FROM (SELECT 
					a.NoTransaksi,
					a.TglTagihan,
					a.TglJatuhTempo,
					a.NISSiswa,
					a.NamaSiswa,
					a.TahunAjaran,
					CONCAT(d.NamaKelas,' / ', c.NamaJurusan) KelasJurusan,
					CONCAT('Tagihan Siswa Bulan ', fnGetMonthName(MONTH(a.TglTagihan)),' - ' , YEAR(TglTagihan)) Note,
					a.Keterangan,
					'Open' Status,
					SUM(a1.JumlahTagihan) - COALESCE(d.Jumlah, 0) TotalTagihan
				FROM tagihanheader a
				LEFT JOIN tagihandetail a1 on a.NoTransaksi = a1.NoTransaksi
				LEFT JOIN tsiswa b ON A.NISSiswa = b.NIS
				LEFT JOIN tjurusan c on b.Jurusan = c.id
				LEFT JOIN tkelas d on b.Kelas = d.id 
				LEFT JOIN (
					SELECT 
						x.BaseNum,
						x.BaseLine,
						x.KodeItemTagihan,
						SUM(x.Jumlah) Jumlah
					FROM pembayarandetail x
					GROUP BY x.BaseNum,x.BaseLine,x.KodeItemTagihan
				)d on a1.NoTransaksi = d.BaseNum AND a1.LineNumber = d.BaseLine
				WHERE a.TglTransaksi BETWEEN '".$FromDate."' AND '".$ToDate."' ";

			if ($Kelas != "") {
				$SQL .= " AND b.Kelas = '".$Kelas."' ";
			}

			if ($Jurusan != "") {
				$SQL .= " AND b.Jurusan = '".$Jurusan."' ";
			}

			$SQL .= "GROUP BY a.NoTransaksi ) x WHERE 1 = 1 ";

			if ($Status == "Open") {
				$SQL .= " AND x.TotalTagihan > 0 ";
			}
			elseif ($Status == "Close") {
				$SQL .= " AND x.TotalTagihan = 0 ";
			}
			if ($NIS != "") {
				$SQL .= " AND x.NISSiswa = '".$NIS."'";
			}
			$SQL .= "ORDER BY x.TglTagihan ";

			$rs = $this->db->query($SQL);

			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			echo json_encode($data);
		}

		public function ReadDetail()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$NoTransaksi = $this->input->post('NoTransaksi');

			$SQL = "SELECT 
				a.*, a.JumlahTagihan - COALESCE(b.Jumlah,0) OutStanding
			FROM tagihandetail a
			LEFT JOIN (
				SELECT 
					x.BaseNum,
					x.BaseLine,
					x.KodeItemTagihan,
					SUM(x.Jumlah) Jumlah
				FROM pembayarandetail x
				GROUP BY x.BaseNum,x.BaseLine,x.KodeItemTagihan
			) b on b.BaseNum = a.NoTransaksi AND b.BaseLine = a.LineNumber
			where NoTransaksi = '".$NoTransaksi."'";
			$SQL .= "ORDER BY LineNumber ";


			$rs = $this->db->query($SQL);

			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			echo json_encode($data);
		}

		public function ReadPembayaran()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$NoTransaksi = $this->input->post('NoTransaksi');
			// $LineNum = $this->input->post('LineNum');

			$SQL = "SELECT 
						a.NoTransaksi,
						b.TglTransaksi,
						b.Keterangan,
						a.Jumlah
					FROM pembayarandetail a
					LEFT JOIN pembayaranheader b on a.NoTransaksi = b.NoTransaksi
					WHERE a.BaseNum = '".$NoTransaksi."'";
			$SQL .= " ORDER BY B.TglPencatatan DESC ";


			$rs = $this->db->query($SQL);

			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			echo json_encode($data);
		}

		public function AddMassal()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			/*
				SAMPLE JSON FORMAT
				{"TglTransaksi":"2023-06-15","MulaiTagih":"2023-07-01","SelesaiTagih":"2024-06-01","TahunAjaran":"2022-2023","Keterangan":"","ListSiswa":[{"NIS" : "99999999","NamaSiswa" : "Prasetyo Aji Wibowo"},{"NIS" : "88888888","NamaSiswa" : "Puspitasari"}],"ListDetail":[{"KodeTagihan" : "1","NamaTagihan" : "123","Jumlah":500000}]}
			*/
			$oParam = json_decode($this->input->post('oParam'));

			$tMulaiTagih = new DateTime($oParam->MulaiTagih);
			$tSelesaiTagih = new DateTime($oParam->SelesaiTagih);

			// var_dump($NoTransaksi);

			$iterateCount = $tMulaiTagih->diff($tSelesaiTagih)->m;

			$nError = 0;
			$sError = '';

			$this->db->trans_begin();

			try {
				for ($i=0; $i < $iterateCount +1 ; $i++) { 
					$objListSiswa = $oParam->ListSiswa;
					// var_dump($objListSiswa);
					$objDetail = $oParam->ListDetail;

					if (count($objListSiswa) > 0) {
						$row = 0;
						foreach ($objListSiswa as $key) {
							// var_dump($key->NIS);
							$tmpTglTagihan = date_format($tMulaiTagih,'Y-m-d');
							$TglTagihan = strtotime($tmpTglTagihan.' + '.$i.' month');

							// var_dump(date('Y-m-d',$TglTagihan));
							$TglJatuhTempo = strtotime(date('Y-m-d',$TglTagihan).' + 7 days');
							
							// $fixNoTrans = $NoTransaksi.$i.$row;

							$Prefix = date("Ym")."1".$key->NIS;

							$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'tagihanheader');
							$NoTransaksi = $Prefix.str_pad($temp, 3,"0",STR_PAD_LEFT);
							
							$oDBParam = array(
								'NoTransaksi' => $NoTransaksi,
								'TglTransaksi' => $oParam->TglTransaksi,
								'TglPencatatan' => date("y-m-d h:i:s"),
								'TglTagihan' => date('Y-m-d',$TglTagihan),
								'TglJatuhTempo' => date('Y-m-d', $TglJatuhTempo),
								'TahunAjaran' => $oParam->TahunAjaran,
								'NISSiswa' => $key->NIS,
								'NamaSiswa' => $key->NamaSiswa,
								'Keterangan' => $oParam->Keterangan,
							);

							$this->ModelsExecuteMaster->ExecInsert($oDBParam,'tagihanheader');

							// Detail
							$lineNum = 0;
							foreach ($objDetail as $keyDetail) {
								$oDBParamDetail = array(
									'NoTransaksi' => $NoTransaksi,
									'LineNumber' => $lineNum,
									'KodeItemTagihan' => $keyDetail->KodeTagihan,
									'NamaItemTagihan' => $keyDetail->NamaTagihan,
									'JumlahTagihan' => $keyDetail->Jumlah,
								);

								$this->ModelsExecuteMaster->ExecInsert($oDBParamDetail,'tagihandetail');
								$lineNum += 1;	
							}

							$row += 1;

							// var_dump(json_encode($oDBParam));
						}
					}else{
						$nError = 404.1;
						$sError = "Object Siswa Not Found";
						goto jump;
					}
				}	
			} catch (Exception $e) {
				$nError = 400;
				$sError = "Exception Error ".$e->getMessage();
				goto jump;
			}

jump:
			if ($this->db->trans_status() === FALSE || $nError != 0){
				// echo $sError;
			    $this->db->trans_rollback();
			    $data['success'] = false;
				$data['message'] = $sError;
			}else{
			    $this->db->trans_commit();
			    $data['success'] = true;
				$data['message'] = "Data Berhasil disimpan";
			}
			echo json_encode($data);
		}

		public function BayarTagihan()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			/*
				SAMPLE JSON FORMAT
				{"TglTransaksi":"2023-06-15","MulaiTagih":"2023-07-01","SelesaiTagih":"2024-06-01","TahunAjaran":"2022-2023","Keterangan":"","ListSiswa":[{"NIS" : "99999999","NamaSiswa" : "Prasetyo Aji Wibowo"},{"NIS" : "88888888","NamaSiswa" : "Puspitasari"}],"ListDetail":[{"KodeTagihan" : "1","NamaTagihan" : "123","Jumlah":500000}]}
			*/
			$oParam = json_decode($this->input->post('oParam'));

			$TglTransaksi = $oParam->TglTransaksi;
			$Keterangan = $oParam->Keterangan;
			$NamaUser = $oParam->NamaUser;

			$Prefix = date("Ym")."2";

			$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'pembayaranheader');
			$NoTransaksi = $Prefix.str_pad($temp, 6,"0",STR_PAD_LEFT);
			

			$nError = 0;
			$sError = '';

			$this->db->trans_begin();

			try {
				$objListDetail = $oParam->ListDetail;

				$oDBParam = array(
					'NoTransaksi' => $NoTransaksi,
					'TglTransaksi' => $TglTransaksi,
					'TglPencatatan' => date("y-m-d h:i:s"),
					'Keterangan' => $Keterangan,
					'CreatedBy' => $NamaUser,
					'CreatedOn'	=> date("y-m-d h:i:s")
				);

				$this->ModelsExecuteMaster->ExecInsert($oDBParam,'pembayaranheader');

				if (count($objListDetail) > 0) {
					$lineNum = 0;
					foreach ($objListDetail as $key) {
						$oDBParamDetail = array(
							'NoTransaksi' => $NoTransaksi,
							'LineNumber' => $lineNum,
							'KodeItemTagihan' => $key->KodeItemTagihan,
							'NamaItemTagihan' => $key->NamaItemTagihan,
							'Jumlah' => $key->JumlahPembayaran,
							'BaseNum' => $key->BaseNum,
							'BaseLine' => $key->BaseLine
						);
						$this->ModelsExecuteMaster->ExecInsert($oDBParamDetail,'pembayarandetail');
						$lineNum += 1;
					}
				}
				else{
					$nError = 301;
					$sError = "Object Detail Not Found";
					goto jump;
				}
			} catch (Exception $e) {
				$nError = 400;
				$sError = "Exception Error ".$e->getMessage();
				goto jump;
			}

			jump:
			if ($this->db->trans_status() === FALSE || $nError != 0){
				// echo $sError;
			    $this->db->trans_rollback();
			    $data['success'] = false;
				$data['message'] = $sError;
			}else{
			    $this->db->trans_commit();
			    $data['success'] = true;
				$data['message'] = "Data Berhasil disimpan";
			}
			echo json_encode($data);
		}
	}
?>