<?php 
	class C_Report extends CI_Controller {
		private $table = 'tjurusan';

		function __construct()
		{
			parent::__construct();
			$this->load->model('ModelsExecuteMaster');
			$this->load->model('GlobalVar');
			$this->load->model('LoginMod');
		}

		public function callReport()
		{
			$oParam = $this->input->post('oParam');
			$viewName = $this->input->post('viewName');
			$data['oParam'] = $oParam;
			$xData = $this->load->view('V_Report/'.$viewName, $data,TRUE); 

			// $this->set_output($xData);
			echo $xData;
		}

		public function pembayaransiswa()
		{
			$data = array('success' => false ,'message'=>array(),'data'=>array());

			$TglAwal = $this->input->post('TglAwal');
			$TglAkhir = $this->input->post('TglAkhir');
			
			$SQL = "
				SELECT 
					e.KodePosKeuangan,
					e.NamaPos,
					f.NIS,
					f.NamaSiswa,
					g.NamaKelas,
					h.NamaJurusan,
					CONCAT(g.NamaKelas,' - ',h.NamaJurusan) ConcatKelas,
					b.NoTransaksi,
					DATE_FORMAT(b.TglTransaksi,'%d/%m/%Y') TglTransaksi,
					b.Keterangan,
					a.Jumlah
				FROM pembayarandetail a
				LEFT JOIN pembayaranheader b on a.NoTransaksi = b.NoTransaksi
				LEFT JOIN tagihandetail c on a.BaseNum = c.NoTransaksi and a.BaseLine = c.LineNumber
				LEFT JOIN tagihanheader c1 on c.NoTransaksi = c1.NoTransaksi
				LEFT JOIN tjenistagihan d on c.KodeItemTagihan =d.KodeTagihan
				LEFT JOIN tposkeuangan e on d.KodePosKeuangan = e.KodePosKeuangan
				LEFT JOIN tsiswa f on c1.NISSiswa = f.NIS
				LEFT JOIN tkelas g on f.Kelas = g.id
				LEFT JOIN tjurusan h on f.Jurusan = h.id
				WHERE b.TglTransaksi BETWEEN '".$TglAwal."' AND '".$TglAkhir."'
			";
			$rs = $this->db->query($SQL);
			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			echo json_encode($data);
		}
	}
?>