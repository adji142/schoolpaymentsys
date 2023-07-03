<?php
defined('BASEPATH') OR exit('No direct script access allowed');
// use PHPMailer\PHPMailer\PHPMailer;
// use PHPMailer\PHPMailer\Exception;

class home extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */
	function __construct()
	{
		parent::__construct();
		$this->load->model('ModelsExecuteMaster');
		$this->load->model('GlobalVar');
		$this->load->model('Apps_mod');
		$this->load->model('LoginMod');
		// require APPPATH.'libraries/phpmailer/src/Exception.php';
  //       require APPPATH.'libraries/phpmailer/src/PHPMailer.php';
  //       require APPPATH.'libraries/phpmailer/src/SMTP.php';
	}
	public function Test()
	{
		$reciept = "prasetyoajiw@gmail.com";
		$subject = "Notifikasi Pembayaran";
		$body = $this->ModelsExecuteMaster->DefaultBody();
		$body .= $this->ModelsExecuteMaster->Email_payment('202108705495986');
		try {
			$this->ModelsExecuteMaster->SendSpesificEmail($reciept,$subject,$body);
		} catch (Exception $e) {
			echo $e->getMessage();
		}
		// try {
		// 	$rs = $this->ModelsExecuteMaster->ExecInsert(array('Nomor'=>'1001'),'ttest');
		// 	if ($rs) {
		// 		print_r('done');
		// 	}
		// 	else{
		// 		goto jump;	
		// 		// var_dump();
		// 	}
		// } catch (Exception $e) {
		// 	jump:
		// 	$undone = $this->db->error();
		// 	print_r('undone'.$undone['message']);
		// }
		// $data = array('success' => false ,'message'=>array(),'Nomor' => '');
		$CreatedOn = date("Y-m-d h:i:sa");
		// echo (substr(date("Y",$CreatedOn), 2,4).date("m",$CreatedOn)."1");
		echo date("m");

		// $Kolom = $this->input->post('Kolom');
		// $Table = $this->input->post('Table');
		// $Prefix = $this->input->post('Prefix');

		// $Kolom = 'ArticleCode';
		// $Table = 'articlewarna';
		// $Prefix = '1';

		// $SQL = "SELECT RIGHT(MAX(".$Kolom."),3)  AS Total FROM " . $Table . " WHERE LEFT(" . $Kolom . ", LENGTH('".$Prefix."')) = '".$Prefix."'";

		// // var_dump($SQL);
		// $rs = $this->db->query($SQL);

		// $temp = $rs->row()->Total + 1;

		// $nomor = $Prefix.str_pad($temp, 3,"0",STR_PAD_LEFT);
		// if ($nomor != '') {
		// 	$data['success'] = true;
		// 	$data['nomor'] = $nomor;
		// }
		// echo json_encode($data);

		
	}
	public function index()
	{
		$this->load->view('Dashboard');
	}
	// --------------------------------------- Master ----------------------------------------------------
	public function permission()
	{
		$this->load->view('V_Auth/permission');
	}
	public function role()
	{
		$this->load->view('V_Auth/roles');
	}
	public function permissionrole($value)
	{
		$rs = $this->ModelsExecuteMaster->FindData(array('id'=>$value),'roles');
		$data['roleid'] = $value;
		$data['rolename'] = $rs->row()->rolename;
		$this->load->view('V_Auth/permissionrole',$data);	
	}
	public function user()
	{
		$this->load->view('V_Auth/users');
	}
	public function login()
	{
		$this->load->view('Index');
	}
	public function changePass()
	{
		$this->load->view('changepassword');
	}
	// Master Data

	public function mstr_jurusan()
	{
		$this->load->view('V_Master/Jurusan');
	}
	public function mstr_kelas()
	{
		$this->load->view('V_Master/Kelas');
	}
	public function mstr_siswa()
	{
		$this->load->view('V_Master/Siswa');
	}
	public function mstr_poskeuangan()
	{
		$this->load->view('V_Master/PosKeuangan');
	}
	public function mstr_jenistagihan()
	{
		$this->load->view('V_Master/JenisTagihan');
	}
	public function profile()
	{
		$this->load->view('V_Auth/profile');
	}
	public function mstr_bank()
	{
		$this->load->view('V_Master/Bank');
	}
	// Laporan

	// TRX
	public function tagihansiswa()
	{
		$this->load->view('V_Transaksi/view_tagihan');
	}
	public function tambahtagihan()
	{
		$this->load->view('V_Transaksi/add_tagihan');
	}
	public function pembayaran()
	{
		$this->load->view('V_Transaksi/view_pembayaran');
	}
	public function bukukas()
	{
		$this->load->view('V_Transaksi/view_bukukas');
	}
	// TRX
	public function rptbuktibayar($value)
	{
		$data['NoTransaksi'] = $value;
		$this->load->view('V_Report/rpt_buktibayar',$data);
	}
	public function rpttagihansiswa()
	{
		$this->load->view('V_Report/rpt_tagihansiswa');
	}
	public function viewpembayaransiswa()
	{
		$this->load->view('V_Report/view_penerimaanpembayaran');
	}
	public function rptpembayaransiswa($oParam)
	{
		$data['oParam'] = $oParam;
		$this->load->view('V_Report/rpt_pembayaranpersiswa',$data);
	}
	public function viewkeuangan()
	{
		$this->load->view('V_Report/view_laporankeuangan');
	}
	public function rptkeuangan($oParam)
	{
		$data['oParam'] = $oParam;
		$this->load->view('V_Report/rpt_laporankeuangan',$data);
	}
}
