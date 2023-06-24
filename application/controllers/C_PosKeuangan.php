<?php 
	class C_PosKeuangan extends CI_Controller {
		private $table = 'tposkeuangan';

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

			$KodePosKeuangan = $this->input->post('KodePosKeuangan');
			$JenisPos = $this->input->post('JenisPos');

			$SQL = "SELECT KodePosKeuangan,NamaPos,JenisPos, CASE WHEN JenisPos = 1 THEN 'Pemasukan' ELSE CASE WHEN JenisPos = 0 THEN 'Pengeluaran' ELSE 'Unknown' END  END NamaJenisPos FROM tposkeuangan WHERE 1 = 1 ";
			
			if ($KodePosKeuangan != "") {
				$SQL .= "AND KodePosKeuangan = '".$KodePosKeuangan."' ";
			}
			if ($JenisPos != "") {
				$SQL .= "AND JenisPos = '".$JenisPos."' ";
			}

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

			$KodePosKeuangan = $this->input->post('KodePosKeuangan');
			$NamaPos = $this->input->post('NamaPos');
			$JenisPos = $this->input->post('JenisPos');
			$formtype = $this->input->post('formtype');

			$param = array(
				'KodePosKeuangan'	=> $KodePosKeuangan,
				'NamaPos'			=> $NamaPos,
				'JenisPos'			=> $JenisPos
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
					$data['message'] = "Gagal Tambah data Pos Keuangan";
				}
			}
			elseif ($formtype == 'edit') {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('KodePosKeuangan'=>$KodePosKeuangan),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Edit data Pos Keuangan";
				}
			}
			elseif ($formtype == 'delete') {
				$rs = $this->ModelsExecuteMaster->DeleteData(array('KodePosKeuangan'=>$KodePosKeuangan),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Delete data Pos Keuangan";
				}
			}
			else{
				$data['message'] = "Invalid Form Type";
			}
			echo json_encode($data);
		}
	}
?>