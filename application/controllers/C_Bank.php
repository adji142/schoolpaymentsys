<?php 
	class C_Bank extends CI_Controller {
		private $table = 'tbank';

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

			$NoRekening = $this->input->post('NoRekening');
			$rs;
			if ($NoRekening != "") {
				$rs = $this->ModelsExecuteMaster->FindData(array('NoRekening'=>$NoRekening),$this->table);
			}
			else{
				$rs = $this->ModelsExecuteMaster->GetData($this->table);
			}

			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			echo json_encode($data);
		}
		public function CRUD()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$NoRekening 		= $this->input->post('NoRekening');
			$NamaBank	 		= $this->input->post('NamaBank');
			$AlamatPenerbit 	= $this->input->post('AlamatPenerbit');
			$increaseAccount 	= $this->input->post('increaseAccount');
			$decreaseAccount 	= $this->input->post('decreaseAccount');

			$formtype 		= $this->input->post('formtype');

			$param = array(
				'NoRekening'		=> $NoRekening,
				'NamaBank'			=> $NamaBank,
				'AlamatPenerbit'	=> $AlamatPenerbit,
				'increaseAccount'	=> $increaseAccount,
				'decreaseAccount'	=> $decreaseAccount
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
					$data['message'] = "Gagal Tambah data Jurusan";
				}
			}
			elseif ($formtype == 'edit') {
				$rs = $this->ModelsExecuteMaster->ExecUpdate($param,array('NoRekening'=>$NoRekening),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Edit data Jurusan";
				}
			}
			elseif ($formtype == 'delete') {
				$rs = $this->ModelsExecuteMaster->DeleteData(array('NoRekening'=>$NoRekening),$this->table);
				if ($rs) {
					$data['success'] = true;
					$data['message'] = "Data Berhasil Disimpan";
				}
				else{
					$data['message'] = "Gagal Delete data Jurusan";
				}
			}
			else{
				$data['message'] = "Invalid Form Type";
			}
			echo json_encode($data);
		}
	}
?>