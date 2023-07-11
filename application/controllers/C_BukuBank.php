<?php 
	class C_BukuBank extends CI_Controller {
		private $table = 'mutasibank';

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

			$TglAwal = $this->input->post('FromDate');
			$TglAkhir = $this->input->post('ToDate');
			
			$SQL = "CALL vsp_show_buku_bank('".$TglAwal."','".$TglAkhir."')";

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

			$JenisMutasi = $this->input->post('JenisMutasi');
			$TglTransaksi = $this->input->post('TglTransaksi');
			$NoRekening = $this->input->post('NoRekening');
			$Jumlah = $this->input->post('Jumlah');
			$Keterangan = $this->input->post('Keterangan');
			$formtype = $this->input->post('formtype');

			$errormessage = '';

			$param = array();

			$param = array(
				'NoRekening' => $NoRekening,
				'JenisMutasi' => $JenisMutasi,
				'TglTransaksi' => $TglTransaksi,
				'TglPencatatan' => date("y-m-d h:i:s"),
				'Debit' => $JenisMutasi == 1 ? $Jumlah : 0,
				'Kredit' => $JenisMutasi == 2 ? $Jumlah : 0 ,
				'Keterangan' => $Keterangan,
			);

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
			jump:
			echo json_encode($data);
		}
	}
?>