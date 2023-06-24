<?php 
	class C_BukuKas extends CI_Controller {
		private $table = 'bukukas';

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
			
			$SQL = "CALL vsp_show_buku_kas('".$TglAwal."','".$TglAkhir."')";

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
			$KodeAkun = $this->input->post('KodeAkun');
			$TglTransaksi = $this->input->post('TglTransaksi');
			$Jumlah = $this->input->post('Jumlah');
			$Keterangan = $this->input->post('Keterangan');
			$formtype = $this->input->post('formtype');

			$errormessage = '';

			if ($JenisMutasi == "1") {
				$Prefix = "BM".date("Ym");
				$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'bukukas','BaseNum');
				$NoTransaksi = $Prefix.str_pad($temp, 5,"0",STR_PAD_LEFT);

				$param = array(
					'TglTransaksi' => $TglTransaksi,
					'TglPencatatan' => date("y-m-d h:i:s"),
					'KodeAkun' => $KodeAkun,
					'Keterangan' => $Keterangan,
					'UangMasuk' => $Jumlah,
					'UangKeluar' => 0,
					'BaseNum' => $NoTransaksi,
					'BaseLine' => 0
				);
			}elseif ($JenisMutasi == "0") {
				$Prefix = "BK".date("Ym");
				$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'bukukas','BaseNum');
				$NoTransaksi = $Prefix.str_pad($temp, 5,"0",STR_PAD_LEFT);

				$param = array(
					'TglTransaksi' => $TglTransaksi,
					'TglPencatatan' => date("y-m-d h:i:s"),
					'KodeAkun' => $KodeAkun,
					'Keterangan' => $Keterangan,
					'UangMasuk' => 0,
					'UangKeluar' => $Jumlah,
					'BaseNum' => $NoTransaksi,
					'BaseLine' => 0
				);
			}else{
				$data['success'] = false;
				$data['message'] = "Invalid Cash Type";
				goto jump;
			}

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