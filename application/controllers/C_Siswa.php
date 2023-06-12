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
	}
?>