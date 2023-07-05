<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'dashboard';
?>
<!-- page content -->
<div class="right_col" role="main">
  <div class="row">
    <div class="col-md-12">
      <div class="">
        <div class="x_content">
          <row>
            <div class="col-md-12">
              <center>
                <img src="<?php echo base_url().'Assets/images/logo.png' ?>" width='30%'>
              </center>
            </div>
            <div class="col-md-12">
              <center>
                <H1>
                  SELAMAT DATANG
                </H1>
                <h6>
                  Sistem Penctatan Keuangan SMK Al Islam KaliJambe
                </h6>
                <H3>
                  <?php echo $this->session->userdata('NamaUser'); ?>
                </H3>
              </center>
            </div>
          </row>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- /page content -->
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>

<!-- <script type="text/javascript">
  $(function () {
    $(document).ready(function () {
      setInterval(function () {
        $.ajax({
          type: "post",
          url: "<?=base_url()?>C_Transaksi/getSaldoPerAccount",
          data: {'UserID':''},
          dataType: "json",
          xhrFields: {
            onprogress: function(e){
              var response = e.currentTarget.response;
              console.log(response);
            }
          }
        });
      },10000);
    });
  });
</script> -->