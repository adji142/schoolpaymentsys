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

			$SQL = "SELECT 
					a.NoTransaksi,
					a.TglTagihan,
					a.TglJatuhTempo,
					a.NISSiswa,
					a.NamaSiswa,
					a.TahunAjaran,
					CONCAT(d.NamaKelas,' / ', c.NamaJurusan) KelasJurusan,
					CONCAT('Tagihan Siswa Bulan ', fnGetMonthName(MONTH(a.TglTagihan)),' - ' , YEAR(TglTagihan)) Note,
					a.Keterangan,
					'Open' Status
				FROM tagihanheader a
				LEFT JOIN tsiswa b ON A.NISSiswa = b.NIS
				LEFT JOIN tjurusan c on b.Jurusan = c.id
				LEFT JOIN tkelas d on b.Kelas = d.id WHERE a.TglTransaksi BETWEEN '".$FromDate."' AND '".$ToDate."' ";

			if ($Kelas != "") {
				$SQL .= " AND b.Kelas = '".$Kelas."' ";
			}

			if ($Jurusan != "") {
				$SQL .= " AND b.Jurusan = '".$Jurusan."' ";
			}

			if ($Status != "") {
				$SQL .= "";
			}

			$SQL .= "ORDER BY a.TglTagihan ";

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

			$SQL = "SELECT * FROM tagihandetail where NoTransaksi = '".$NoTransaksi."'";
			$SQL .= "ORDER BY LineNumber ";


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

			$Prefix = date("Ym");

			$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'tagihanheader');
			$NoTransaksi = $Prefix.str_pad(($temp == 1)?$temp:$temp+1, 5,"0",STR_PAD_LEFT);
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
							
							$fixNoTrans = $NoTransaksi.$i.$row;
							$oDBParam = array(
								'NoTransaksi' => $fixNoTrans,
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
									'NoTransaksi' => $fixNoTrans,
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
	}
?>