<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'dashboard';
?>
<!-- page content -->
        <div class="right_col" role="main">
          <div class="">

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Siswa</h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-md-3 col-sm-12  form-group">
                        Jurusan
                        <select id="Jurusan" name="Jurusan" class="form-control">
                          <option value="">Pilih Jurusan..</option>
                          <?php
                            $rs = $this->ModelsExecuteMaster->GetData('tjurusan')->result();

                            foreach ($rs as $key) {
                              echo "<option value = '".$key->id."'>".$key->NamaJurusan."</option>";
                            }
                          ?>
                        </select>
                      </div>

                      <div class="col-md-3 col-sm-12  form-group">
                        Kelas
                        <select id="Kelas" name="Kelas" class="form-control">
                          <option value="">Pilih Kelas..</option>
                          <?php
                            $rs = $this->ModelsExecuteMaster->GetData('tkelas')->result();

                            foreach ($rs as $key) {
                              echo "<option value = '".$key->id."'>".$key->NamaKelas."</option>";
                            }
                          ?>
                        </select>
                      </div>
                      <div class="col-md-4 col-sm-12  form-group">
                        <!-- <input type="text" placeholder="NIK / Nama" class="form-control"> -->
                        <br>
                        <button class="btn btn-primary" id="btSearch">Cari Data</button>
                        <button class="btn btn-warning" id="btNaikKelas">Naik Kelas</button>
                      </div>
                      <div class="dx-viewport demo-container">
                        <div id="data-grid-demo">
                          <div id="gridContainer">
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Modal Siswa</h4>
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body">
                <form id="post_" data-parsley-validate class="form-horizontal form-label-left">
                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">NIS <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="NIS" id="NIS" required="" placeholder="NIS" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Siswa <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="NamaSiswa" id="NamaSiswa" required="" placeholder="Nama Siswa" class="form-control ">
                      <input type="hidden" name="formtype" id="formtype" value="add">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Alamat Siswa <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <!-- <input type="text" name="AlamatSiswa" id="Alamat Siswa" required="" placeholder="Alamat Siswa" class="form-control "> -->
                      <textarea class="form-control" rows="3" placeholder="Alamat SIswa" name="AlamatSiswa" id="AlamatSiswa"></textarea>
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Wali <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="NamaWali" id="NamaWali" required="" placeholder="Nama Wali" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Kelas <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <select class="form-control " name="Kelas" id="Kelas">
                        <option value="">Pilih Kelas</option>
                        <?php
                          $rs = $this->ModelsExecuteMaster->GetData('tkelas')->result();

                          foreach ($rs as $key) {
                            echo "<option value = '".$key->id."'>".$key->NamaKelas."</option>";
                          }
                        ?>
                      </select>
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Jurusan <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <select class="form-control " name="Jurusan" id="Jurusan">
                        <option value="">Pilih Jurusan</option>
                        <?php
                          $rs = $this->ModelsExecuteMaster->GetData('tjurusan')->result();

                          foreach ($rs as $key) {
                            echo "<option value = '".$key->id."'>".$key->NamaJurusan."</option>";
                          }
                        ?>
                      </select>
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Tempat Lahir
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="TempatLahir" id="TempatLahir" placeholder="Tempat Lahir" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Tanggal Lahir
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="date" name="TglLahir" id="TglLahir" placeholder="Tempat Lahir" class="date-picker form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">No.Tlp Siswa(WhatsApp)
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="NoTlpSiswa" id="NoTlpSiswa" placeholder="No.Tlp Siswa(WhatsApp)" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">No.Tlp Wali(WhatsApp)
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="NoTlpWali" id="NoTlpWali" placeholder="No.Tlp Wali(WhatsApp)" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Email
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <input type="text" name="Email" id="Email" placeholder="Email" class="form-control ">
                    </div>
                  </div>

                  <div class="item form-group">
                    <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Angkatan <span class="required">*</span>
                    </label>
                    <div class="col-md-6 col-sm-6 ">
                      <select class="form-control " name="TahunAngkatan" id="TahunAngkatan">
                        <option value="">Pilih Angkatan</option>
                        <div id="tahunajaran"></div>
                      </select>
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

        <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modalNaikKelas">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Modal Naik Kelas</h4>
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body">
                <div class="item form-group">
                  <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Jurusan <span class="required">*</span>
                  </label>
                  <div class="col-md-6 col-sm-6 ">
                    <select class="form-control " name="NaikJurusan" id="NaikJurusan">
                      <option value="">Pilih Jurusan</option>
                      <?php
                        $rs = $this->ModelsExecuteMaster->GetData('tjurusan')->result();

                        foreach ($rs as $key) {
                          echo "<option value = '".$key->id."'>".$key->NamaJurusan."</option>";
                        }
                      ?>
                    </select>
                  </div>
                </div>

                <div class="item form-group">
                  <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Kelas <span class="required">*</span>
                  </label>
                  <div class="col-md-6 col-sm-6 ">
                    <select class="form-control " name="KelasFrom" id="KelasFrom">
                      <option value="">Pilih Kelas</option>
                      <?php
                        $rs = $this->ModelsExecuteMaster->GetData('tkelas')->result();

                        foreach ($rs as $key) {
                          echo "<option value = '".$key->id."'>".$key->NamaKelas."</option>";
                        }
                      ?>
                    </select>
                  </div>
                </div>

                <div class="item form-group">
                  <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Naik ke Kelas <span class="required">*</span>
                  </label>
                  <div class="col-md-6 col-sm-6 ">
                    <select class="form-control " name="KelasTo" id="KelasTo">
                      <option value="">Pilih Kelas</option>
                      <?php
                        $rs = $this->ModelsExecuteMaster->GetData('tkelas')->result();

                        foreach ($rs as $key) {
                          echo "<option value = '".$key->id."'>".$key->NamaKelas."</option>";
                        }
                      ?>
                    </select>
                  </div>
                </div>

                <div class="item" form-group>
                  <button class="btn btn-primary" id="btn_SaveNaikKelas">Save</button>
                </div>
              </div>
              <!-- <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                
              </div> -->

            </div>
          </div>
        </div>
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>
<script type="text/javascript">
  $(function () {
        $(document).ready(function () {
          var where_field = '';
          var where_value = '';
          var table = 'users';

          populateData();

          var thisYear = new Date().getFullYear();
          var incrementUp = 5;
          var incrementDown = 5;

          var htmlTag = "";

          for (var i = incrementDown; i >= 0; i--) {
            // console.log(thisYear-i);
            var tempTahun = thisYear-i;
            htmlTag += '<option value="'+ tempTahun +'">'+ tempTahun +'</option>';
          }

          for (var i = 1; i < incrementUp; i++) {
            // console.log(thisYear-i);
            var tempTahun = thisYear+i;
            htmlTag += '<option value="'+ tempTahun +'">'+ tempTahun +'</option>';
          }

          $("#TahunAngkatan").append(htmlTag);
          // console.log(htmlTag);
          $('#TahunAngkatan').val(thisYear).change();


        });

        function populateData() {
          $.ajax({
            type: "post",
            url: "<?=base_url()?>C_Siswa/Read",
            data: {'NIS':'','Kelas':$('#Kelas').val(),'Jurusan':$('#Jurusan').val()},
            dataType: "json",
            success: function (response) {
              bindGrid(response.data);
            }
          });
        }
        $('#post_').submit(function (e) {
          $('#btn_Save').text('Tunggu Sebentar.....');
          $('#btn_Save').attr('disabled',true);

          e.preventDefault();
          var me = $(this);

          $.ajax({
            type    :'post',
            url     : '<?=base_url()?>C_Siswa/CRUD',
            data    : me.serialize(),
            dataType: 'json',
            success : function (response) {
              if(response.success == true){
                $('#modal_').modal('toggle');
                Swal.fire({
                  type: 'success',
                  title: 'Horay..',
                  text: 'Data Berhasil disimpan!',
                  // footer: '<a href>Why do I have this issue?</a>'
                }).then((result)=>{
                  location.reload();
                });
              }
              else{
                $('#modal_').modal('toggle');
                Swal.fire({
                  type: 'error',
                  title: 'Woops...',
                  text: response.message,
                  // footer: '<a href>Why do I have this issue?</a>'
                }).then((result)=>{
                  $('#modal_').modal('show');
                  $('#btn_Save').text('Save');
                  $('#btn_Save').attr('disabled',false);
                });
              }
            }
          });
        });
        $('.close').click(function() {
          location.reload();
        });
        $('#btSearch').click(function () {
          populateData();
        });
        $('#btNaikKelas').click(function () {
          $('#modalNaikKelas').modal('show');
        });

        $('#btn_SaveNaikKelas').click(function () {
          $('#btn_SaveNaikKelas').text('Tunggu Sebentar.....');
          $('#btn_SaveNaikKelas').attr('disabled',true);

          $.ajax({
            type    :'post',
            url     : '<?=base_url()?>C_Siswa/fnNaikKelas',
            data    : {'NaikJurusan' : $('#NaikJurusan').val(),'KelasFrom': $('#KelasFrom').val(),'KelasTo': $('#KelasTo').val()},
            dataType: 'json',
            success : function (response) {
              if(response.success == true){
                $('#modalNaikKelas').modal('toggle');
                Swal.fire({
                  type: 'success',
                  title: 'Horay..',
                  text: 'Data Berhasil disimpan!',
                  // footer: '<a href>Why do I have this issue?</a>'
                }).then((result)=>{
                  location.reload();
                });
              }
              else{
                $('#modalNaikKelas').modal('toggle');
                Swal.fire({
                  type: 'error',
                  title: 'Woops...',
                  text: response.message,
                  // footer: '<a href>Why do I have this issue?</a>'
                }).then((result)=>{
                  $('#modalNaikKelas').modal('show');
                  $('#btn_SaveNaikKelas').text('Save');
                  $('#btn_SaveNaikKelas').attr('disabled',false);
                });
              }
            }
          });
        })
    function GetData(id) {
      var where_field = 'id';
      var where_value = id;
      var table = 'users';
      $.ajax({
            type: "post",
            url: "<?=base_url()?>C_Siswa/Read",
            data: {'NIS':id},
            dataType: "json",
            success: function (response) {
              $.each(response.data,function (k,v) {
                // console.log(v.KelompokUsaha);
                // $('#KodePenyakit').val(v.KodePenyakit).change;
                $('#NIS').val(v.NIS);
                $('#NamaSiswa').val(v.NamaSiswa);
                $('#AlamatSiswa').val(v.AlamatSiswa);
                $('#NamaWali').val(v.NamaWali);
                $('#Kelas').val(v.Kelas).change();
                $('#Jurusan').val(v.Jurusan).change();
                $('#TempatLahir').val(v.TempatLahir);
                $('#TglLahir').val(v.TglLahir);
                $('#NoTlpSiswa').val(v.NoTlpSiswa);
                $('#NoTlpWali').val(v.NoTlpWali);
                $('#Email').val(v.Email);
                $('#TahunAngkatan').val(v.TahunAngkatan).change();

                $('#formtype').val("edit");

                $('#modal_').modal('show');
              });
            }
          });
    }
    function bindGrid(data) {

      $("#gridContainer").dxDataGrid({
        allowColumnResizing: true,
            dataSource: data,
            keyExpr: "NIS",
            showBorders: true,
            allowColumnReordering: true,
            allowColumnResizing: true,
            columnAutoWidth: true,
            showBorders: true,
            paging: {
                enabled: false
            },
            editing: {
                mode: "row",
                allowAdding:true,
                allowUpdating: true,
                allowDeleting: true,
                texts: {
                    confirmDeleteMessage: ''  
                }
            },
            searchPanel: {
                visible: true,
                width: 240,
                placeholder: "Search..."
            },
            export: {
                enabled: true,
                fileName: "Daftar Siswa"
            },
            columns: [
                {
                    dataField: "NIS",
                    caption: "NIS",
                    allowEditing:false
                },
                {
                    dataField: "NamaSiswa",
                    caption: "Nama Siswa",
                    allowEditing:false
                },
                {
                    dataField: "NamaKelas",
                    caption: "Kelas",
                    allowEditing:false
                },
                {
                    dataField: "NamaJurusan",
                    caption: "Jurusan",
                    allowEditing:false
                },
                {
                    dataField: "ttl",
                    caption: "Tempat, Tgl Lahir",
                    allowEditing:false
                },
            ],
            onEditingStart: function(e) {
                GetData(e.data.NIS);
            },
            onInitNewRow: function(e) {
                // logEvent("InitNewRow");
                $('#modal_').modal('show');
            },
            onRowInserting: function(e) {
                // logEvent("RowInserting");
            },
            onRowInserted: function(e) {
                // logEvent("RowInserted");
                // alert('');
                // console.log(e.data.onhand);
                // var index = e.row.rowIndex;
            },
            onRowUpdating: function(e) {
                // logEvent("RowUpdating");
                
            },
            onRowUpdated: function(e) {
                // logEvent(e);
            },
            onRowRemoving: function(e) {
              id = e.data.NIS;
              Swal.fire({
                title: 'Apakah anda yakin?',
                text: "anda akan menghapus data di baris ini !",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
              }).then((result) => {
                if (result.value) {
                  var table = 'app_setting';
                  var field = 'id';
                  var value = id;

                  $.ajax({
                      type    :'post',
                      url     : '<?=base_url()?>C_Siswa/CRUD',
                      data    : {'NIS':id,'formtype':'delete'},
                      dataType: 'json',
                      success : function (response) {
                        if(response.success == true){
                          Swal.fire(
                        'Deleted!',
                        'Your file has been deleted.',
                        'success'
                      ).then((result)=>{
                            location.reload();
                          });
                        }
                        else{
                          Swal.fire({
                            type: 'error',
                            title: 'Woops...',
                            text: response.message,
                            // footer: '<a href>Why do I have this issue?</a>'
                          }).then((result)=>{
                            location.reload();
                          });
                        }
                      }
                    });
                  
                }
                else{
                  location.reload();
                }
              })
            },
            onRowRemoved: function(e) {
              // console.log(e);
            },
        onEditorPrepared: function (e) {
          // console.log(e);
        }
        });

        // add dx-toolbar-after
        // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
    }
  });
</script>