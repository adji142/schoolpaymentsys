<?php 
	class C_Siswa extends CI_Controller {
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
						CONCAT(b.NamaKelas,' / ',c.NamaJurusan) KelasJurusan,
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
		public function import()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());
			$temp_data= [];
			$this->db->trans_begin();
			$nError = 0;
			$sError = "";
			try {
				if (isset($_FILES["fileExcel"]["name"])) {
					$path = $_FILES["fileExcel"]["tmp_name"];
					$object = PHPExcel_IOFactory::load($path);
					foreach($object->getWorksheetIterator() as $worksheet){
						$highestRow = $worksheet->getHighestRow();
						$highestColumn = $worksheet->getHighestColumn();

						for($row=2; $row<=$highestRow; $row++){
							$NIS = $worksheet->getCellByColumnAndRow(0, $row)->getValue();
							$NamaSiswa = $worksheet->getCellByColumnAndRow(1, $row)->getValue();
							$AlamatSiswa = $worksheet->getCellByColumnAndRow(2, $row)->getValue();
							$NamaWali = $worksheet->getCellByColumnAndRow(3, $row)->getValue();
							$Kelas = $worksheet->getCellByColumnAndRow(4, $row)->getValue();
							$Jurusan = $worksheet->getCellByColumnAndRow(5, $row)->getValue();
							$TempatLahir = $worksheet->getCellByColumnAndRow(6, $row)->getValue();
							$TglLahir = $worksheet->getCellByColumnAndRow(7, $row)->getValue();
							$NoTlpSiswa = $worksheet->getCellByColumnAndRow(8, $row)->getValue();
							$NoTlpWali = $worksheet->getCellByColumnAndRow(9, $row)->getValue();
							$Email = $worksheet->getCellByColumnAndRow(10, $row)->getValue();
							$TahunAngkatan = $worksheet->getCellByColumnAndRow(11, $row)->getValue();

							$temp_data = array(
								'NIS' => $NIS,
								'NamaSiswa' => $NamaSiswa,
								'AlamatSiswa' => $AlamatSiswa,
								'NamaWali' => $NamaWali,
								'Kelas' => $Kelas,
								'Jurusan' => $Jurusan,
								'TempatLahir' => $TempatLahir,
								'TglLahir' => $TglLahir,
								'NoTlpSiswa' => $NoTlpSiswa,
								'NoTlpWali' => $NoTlpWali,
								'Email' => $Email,
								'TahunAngkatan' => $TahunAngkatan
							); 	

							$rs = $this->ModelsExecuteMaster->ExecInsert($temp_data,$this->table);
							if ($rs) {
								$data['success'] = true;
								$data['message'] = "Data Berhasil Disimpan";
							}
							else{
								$nError += 1;
								$data['message'] = "Gagal Tambah data Siswa";
								goto jump;
							}
						}
					}

					// var_dump($temp_data);
					// redirect($_SERVER['HTTP_REFERER']);
				}
			} catch (Exception $e) {
				$nError+=1;
				$data['success'] = false;
				$data['message'] = "Error " + $e->getMessage();
				goto jump;
			}
			jump:
			if ($this->db->trans_status() === FALSE || $nError != 0){
				// echo $sError;
			    $this->db->trans_rollback();
			    $data['success'] = false;
				$data['message'] = $sError;
				echo "<script> alert('Gagal Menympan Data') </script>";

				redirect(base_url().'siswa'); 
			}else{
			    $this->db->trans_commit();
			    $data['success'] = true;
				$data['message'] = "Data Berhasil disimpan";
				echo "<script> alert('Data Berhasil Disimpan') </script>";
				redirect(base_url().'siswa'); 
			}


		}
		public function CRUD()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$formtype = $this->input->post('formtype');

			$NIS = $this->input->post('NIS');
			$NamaSiswa = $this->input->post('NamaSiswa');
			$AlamatSiswa = $this->input->post('AlamatSiswa');
			$NamaWali = $this->input->post('NamaWali');
			$Kelas = $this->input->post('Kelas');
			$Jurusan = $this->input->post('Jurusan');
			$TempatLahir = $this->input->post('TempatLahir');	
			$TglLahir = $this->input->post('TglLahir');
			$NoTlpSiswa = $this->input->post('NoTlpSiswa');
			$NoTlpWali = $this->input->post('NoTlpWali');
			$Email = $this->input->post('Email');
			$TahunAngkatan = $this->input->post('TahunAngkatan');


			$param = array(
				'NIS' => $NIS,
				'NamaSiswa' => $NamaSiswa,
				'AlamatSiswa' => $AlamatSiswa,
				'NamaWali' => $NamaWali,
				'Kelas' => $Kelas,
				'Jurusan' => $Jurusan,
				'TempatLahir' => $TempatLahir,
				'TglLahir' => $TglLahir,
				'NoTlpSiswa' => $NoTlpSiswa,
				'NoTlpWali' => $NoTlpWali,
				'Email' => $Email,
				'TahunAngkatan' => $TahunAngkatan
			);

			$rs;
			$errormessage = '';
			if ($formtype == 'add') {
				$rs = $this->ModelsExecuteMaster->ExecInsert($param,$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Tambah data Siswa";
				}
			}
			elseif ($formtype == 'edit') {
				$param = array(
					'NIS' => $NIS,
					'NamaSiswa' => $NamaSiswa,
					'AlamatSiswa' => $AlamatSiswa,
					'NamaWali' => $NamaWali,
					'TempatLahir' => $TempatLahir,
					'TglLahir' => $TglLahir,
					'NoTlpSiswa' => $NoTlpSiswa,
					'NoTlpWali' => $NoTlpWali,
					'Email' => $Email
				);
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('NIS'=>$NIS),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Edit data Siswa";
				}
			}
			elseif ($formtype == 'delete') {
				$rs = $this->ModelsExecuteMaster->DeleteData(array('NIS'=>$NIS),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Delete data Siswa";
				}
			}
			else{
				$data['message'] = "Invalid Form Type";
			}
			echo json_encode($data);
		}

		public function fnNaikKelas()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$NaikJurusan 	= $this->input->post('NaikJurusan');
			$KelasFrom 		= $this->input->post('KelasFrom');
			$KelasTo 		= $this->input->post('KelasTo');

			$oParam = array(
				'Kelas' => $KelasTo
			);

			$oWhere = array(
				'Jurusan'	=> $NaikJurusan,
				'Kelas'		=> $KelasFrom
			);

			$rs = $this->ModelsExecuteMaster->ExecUpdate($oParam,$oWhere,$this->table);
			if ($rs) {
				$data['success'] = true;
				$data['message'] = "Data Berhasil Disimpan";
			}
			else{
				$data['message'] = "Gagal Edit data Siswa";
			}

			echo json_encode($data);
		}
	}
?>