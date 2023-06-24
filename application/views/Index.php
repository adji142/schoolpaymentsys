<?php
    $user_id = $this->session->userdata('userid');
    if($user_id != ''){
        echo "<script>location.replace('".base_url()."home');</script>";
    }
    delete_cookie('ci_session');
    $this->session->sess_destroy();
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>AIS SYSTEM! | </title>

    <!-- Bootstrap -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<?php echo base_url();?>Assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<?php echo base_url();?>Assets/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="<?php echo base_url();?>Assets/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="<?php echo base_url();?>Assets/build/css/custom.min.css" rel="stylesheet">
    <script src="<?php echo base_url();?>Assets/js/jquery.min.js"> </script>

    <script src="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.js"></script>
  <link rel="stylesheet" href="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.css">
  </head>

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form id="loginform">
              <h1>Login Form</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" required="" id="username" name="username"/>
                <input type="hidden" name="androidid" id="androidid" value="admin">
              </div>
              <div>
                <input type="password" class="form-control" placeholder="Password" required="" id="password" name="password"/>
              </div>
              <div>
                <button class="btn btn-success">Log in</button>
              </div>

              <div class="clearfix"></div>

              <div class="separator">

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> AIS SYSTEM</h1>
                  <p>©2020 All Rights Reserved. AIS SYSTEM!. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>

      <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_">
        <div class="modal-dialog modal-lg">
          <div class="modal-content">

            <div class="modal-header">
              <h4 class="modal-title" id="myModalLabel">Modal Jurusan</h4>
              <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
              </button>
            </div>
            <div class="modal-body">
              <form id="post_" data-parsley-validate class="form-horizontal form-label-left">
                <div class="item form-group">
                  <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Jurusan <span class="required">*</span>
                  </label>
                  <div class="col-md-6 col-sm-6 ">
                    <input type="text" name="NamaJurusan" id="NamaJurusan" required="" placeholder="Nama Jurusan" class="form-control ">
                    <input type="hidden" name="id" id="id">
                    <input type="hidden" name="formtype" id="formtype" value="add">
                  </div>
                </div>
                <div class="item" form-group>
                  <button class="btn btn-primary" id="btn_Save">Save</button>
                </div>
              </form>
            </div>
            <!-- <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
              
            </div> -->

          </div>
        </div>
      </div>

    </div>
  </body>
</html>
<script type="text/javascript">
    $(function () {
        // Handle CSRF token
        $.ajaxSetup({
            beforeSend:function(jqXHR, Obj){
                var value = "; " + document.cookie;
                var parts = value.split("; csrf_cookie_token=");
                if(parts.length == 2)
                Obj.data += '&csrf_token='+parts.pop().split(";").shift();
            }
        });
        $(document).ready(function () {
            
        });
        // end Handle CSRF token
        $('#loginform').submit(function (e) {
            $('#btn_login').text('Tunggu Sebentar...');
            $('#btn_login').attr('disabled',true);

            e.preventDefault();
            var me = $(this);
            // alert(me.serialize());
            $.ajax({
                type: "post",
                url: "<?=base_url()?>Auth/Log_Pro",
                data: me.serialize(),
                dataType: "json",
                success:function (response) {
                    if(response.success == true){
                      if (response.message == "changepass") {
                        location.replace("<?=base_url()?>Home/changePass")
                      }
                      else{
                        location.replace("<?=base_url()?>Home")
                      }
                    }
                    else{
                        if(response.message == 'L-01'){
                            Swal.fire({
                              type: 'error',
                              title: 'Oops...',
                              text: 'User dan password tidak sesuai dengan database!',
                              // footer: '<a href>Why do I have this issue?</a>'
                            }).then((result)=>{
                                $('#username').val('');
                                $('#password').val('');
                                $('#btn_login').text('Login');
                                $('#btn_login').attr('disabled',false);
                            });
                        }
                        else if(response.message == 'L-02'){
                            Swal.fire({
                              type: 'error',
                              title: 'Oops...',
                              text: 'User tidak di temukan!',
                              footer: '<a href>Why do I have this issue?</a>'
                            }).then((result)=>{
                                $('#username').val('');
                                $('#password').val('');
                                $('#btn_login').text('Login');
                                $('#btn_login').attr('disabled',false);
                            });
                        }
                        else{
                            Swal.fire({
                              type: 'error',
                              title: 'Oops...',
                              text: 'Undefine Error Contact your system administrator!',
                              footer: '<a href>Why do I have this issue?</a>'
                            }).then((result)=>{
                                $('#username').val('');
                                $('#password').val('');
                                $('#btn_login').text('Login');
                                $('#btn_login').attr('disabled',false);
                            });
                        }
                    }
                }
            });
        });
    });
</script>