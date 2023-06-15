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

		public function Read()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$NIS = $this->input->post('NIS');
			$Kelas = $this->input->post('Kelas');
			$Jurusan = $this->input->post('Jurusan');
			$textSearch = $this->input->post('textSearch');

			$SQL = "SELECT 
						a.NIS,
						a.NamaSiswa,
						b.NamaKelas,
						c.NamaJurusan,
						CONCAT(a.TempatLahir,', ',DATE_FORMAT(a.TglLahir,'%d-%m-%Y')) 'ttl',
						a.*
					FROM tsiswa a
					LEFT JOIN tkelas b on a.Kelas = b.id
					LEFT JOIN tjurusan c on a.Jurusan = c.id 
					WHERE CONCAT(a.NIS,' ', a.NamaSiswa) LIKE '%".$textSearch."%'
					";

			if ($NIS != "") {
				$SQL .= " AND a.NIS = '".$NIS."' ";
			}

			if ($Kelas != "") {
				$SQL .= " AND a.Kelas = '".$Kelas."' ";
			}

			if ($Jurusan != "") {
				$SQL .= " AND a.Jurusan = '".$Jurusan."' ";
			}

			$SQL .= "ORDER BY a.NamaSiswa ";

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
				{"TglTransaksi":"2023-06-15","MulaiTagih":"2023-07-01","SelesaiTagih":"2024-06-01","TahunAjaran":"2022-2023","Keterangan":"","ListSiswa":[{"NIS" : "1","NamaSiswa" : "123"},{"NIS" : "2","NamaSiswa" : "456"}],"ListDetail":[{}]}
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
							
							
							$oDBParam = array(
								'NoTransaksi' => $NoTransaksi.$i.$row,
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
				
			}

jump:
			if ($this->db->trans_status() === FALSE || $nError != 0){
				// echo $sError;
				$data['message'] = $sError;
			    $this->db->trans_rollback();
			}else{
			    $this->db->trans_commit();
			}


			// $param = array(
			// 	'NIS' => $NIS,
			// 	'NamaSiswa' => $NamaSiswa,
			// 	'AlamatSiswa' => $AlamatSiswa,
			// 	'NamaWali' => $NamaWali,
			// 	'Kelas' => $Kelas,
			// 	'Jurusan' => $Jurusan,
			// 	'TempatLahir' => $TempatLahir,
			// 	'TglLahir' => $TglLahir,
			// 	'NoTlpSiswa' => $NoTlpSiswa,
			// 	'NoTlpWali' => $NoTlpWali,
			// 	'Email' => $Email,
			// 	'TahunAngkatan' => $TahunAngkatan
			// );

			// $rs;
			// $errormessage = '';
			// if ($formtype == 'add') {
			// 	$rs = $this->ModelsExecuteMaster->ExecInsert($param,$this->table);
			// 	if ($rs) {
			// 		$data['success'] = true;
			// 		$data['message'] = "Data Berhasil Disimpan";
			// 	}
			// 	else{
			// 		$data['message'] = "Gagal Tambah data Siswa";
			// 	}
			// }
			// elseif ($formtype == 'edit') {
			// 	$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('NIS'=>$NIS),$this->table);
			// 	if ($rs) {
			// 		$data['success'] = true;
			// 		$data['message'] = "Data Berhasil Disimpan";
			// 	}
			// 	else{
			// 		$data['message'] = "Gagal Edit data Siswa";
			// 	}
			// }
			// elseif ($formtype == 'delete') {
			// 	$rs = $this->ModelsExecuteMaster->DeleteData(array('NIS'=>$NIS),$this->table);
			// 	if ($rs) {
			// 		$data['success'] = true;
			// 		$data['message'] = "Data Berhasil Disimpan";
			// 	}
			// 	else{
			// 		$data['message'] = "Gagal Delete data Siswa";
			// 	}
			// }
			// else{
			// 	$data['message'] = "Invalid Form Type";
			// }
			echo json_encode($data);
		}
	}
?>