<?php 
	class C_JenisTagihan extends CI_Controller {
		private $table = 'tjenistagihan';

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

			$KodeTagihan = $this->input->post('KodeTagihan');
			
			$SQL = "
				SELECT 
					a.*,
					b.NamaPos
				FROM tjenistagihan a
				LEFT JOIN tposkeuangan b on a.KodePosKeuangan = b.KodePosKeuangan
				WHERE 1 = 1
			";

			if ($KodeTagihan != "") {
				$SQL .= " AND a. KodeTagihan = '".$KodeTagihan."' ";
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

			$KodeTagihan = $this->input->post('KodeTagihan');
			$NamaTagihan = $this->input->post('NamaTagihan');
			$KodePosKeuangan = $this->input->post('KodePosKeuangan');
			$formtype = $this->input->post('formtype');

			$param = array(
				'KodeTagihan'		=> $KodeTagihan,
				'NamaTagihan'		=> $NamaTagihan,
				'KodePosKeuangan'	=> $KodePosKeuangan
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
					$data['message'] = "Gagal Tambah data Jenis Tagihan";
				}
			}
			elseif ($formtype == 'edit') {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('KodeTagihan'=>$KodeTagihan),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Edit data Jenis Tagihan";
				}
			}
			elseif ($formtype == 'delete') {
				$rs = $this->ModelsExecuteMaster->DeleteData(array('KodeTagihan'=>$KodeTagihan),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Delete data Jenis Tagihan";
				}
			}
			else{
				$data['message'] = "Invalid Form Type";
			}
			echo json_encode($data);
		}
	}
?>