<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * 
 */
class GlobalVar extends CI_Model
{
	
	function __construct()
	{
		parent::__construct();
	}
	function GetSideBar($userid,$parent,$usemobile)
	{
		$data = "
			select d.* from users a
			inner join userrole b on a.id = b.userid
			inner join permissionrole c on b.roleid = c.roleid
			inner join permission d on c.permissionid = d.id
			where a.id = $userid 
		";
		if ($usemobile == 1) {
			$data .= "AND d.AllowMobile = 1";
		}
		else{
			$data .= "AND d.menusubmenu = $parent";
		}
		$data .= "
			AND `status` = 1
			order by d.order asc
		";
		return $this->db->query($data);
	}
	public function GetNoTransaksi($prefix, $table, $field = "NoTransaksi")
	{
		$SQL = "SELECT COUNT(*) +1 LastRow FROM ".$table." WHERE LEFT(".$field.", LENGTH('".$prefix."')) = '".$prefix."'";

		$data = $this->db->query($SQL)->row();

		return $data->LastRow;
	}

	public function penyebut($nilai) {
		$nilai = abs($nilai);
		$huruf = array("", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "delapan", "sembilan", "sepuluh", "sebelas");
		$temp = "";
		if ($nilai < 12) {
			$temp = " ". $huruf[$nilai];
		} else if ($nilai <20) {
			$temp = $this.penyebut($nilai - 10). " belas";
		} else if ($nilai < 100) {
			$temp = $this.penyebut($nilai/10)." puluh". $this.penyebut($nilai % 10);
		} else if ($nilai < 200) {
			$temp = " seratus" . $this.penyebut($nilai - 100);
		} else if ($nilai < 1000) {
			$temp = $this.penyebut($nilai/100) . " ratus" . $this.penyebut($nilai % 100);
		} else if ($nilai < 2000) {
			$temp = " seribu" . $this.penyebut($nilai - 1000);
		} else if ($nilai < 1000000) {
			$temp = $this.penyebut($nilai/1000) . " ribu" . $this.penyebut($nilai % 1000);
		} else if ($nilai < 1000000000) {
			$temp = $this.penyebut($nilai/1000000) . " juta" . $this.penyebut($nilai % 1000000);
		} else if ($nilai < 1000000000000) {
			$temp = $this.penyebut($nilai/1000000000) . " milyar" . $this.penyebut(fmod($nilai,1000000000));
		} else if ($nilai < 1000000000000000) {
			$temp = $this.penyebut($nilai/1000000000000) . " trilyun" . $this.penyebut(fmod($nilai,1000000000000));
		}     
		return $temp;
	}
}