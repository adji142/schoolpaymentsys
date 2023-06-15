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
            <h2>Tambah Tagihan</h2>
            <div class="clearfix"></div>
          </div>
          <div class="x_content">
            <div class="row">
              <div class="col-md-2 col-sm-12  form-group">
                No. Transaksi
                <input type="text" id="NoTransaksi" name="NoTransaksi" placeholder="<AUTO>" class="form-control" ReadOnly>
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-3 col-sm-12  form-group">
                Tgl. Transaksi
                <input type="date" id="TglTransaksi" name="TglTransaksi" class="form-control">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-7 col-sm-12  form-group">
                Keterangan
                <input type="text" id="Keterangan" name="Keterangan" class="form-control">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-4 col-sm-12  form-group">
                Periode Tagihan
                <input type="month" id="PeriodFrom" name="PeriodFrom" class="form-control">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-4 col-sm-12  form-group">
                Periode Selesai Tagihan
                <input type="month" id="PeriodTo" name="PeriodTo" class="form-control">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-12 col-sm-12  form-group">
                
              </div>
              <div class="col-md-3 col-sm-12  form-group">
                Mulai Tahun Ajaran
                <input type="text" id="TahunAjaranFrom" name="TahunAjaranFrom" class="form-control" maxlength="4">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-3 col-sm-12  form-group">
                Selesai Tahun Ajaran
                <input type="text" id="TahunAjaranTo" name="TahunAjaranTo" class="form-control" maxlength="4">
                <!-- <span class="tooltiptext">Tooltip text</span> -->
              </div>
              <div class="col-md-12 col-sm-12  form-group">
                <h3><center>Detail Tagihan</center></h3>
              </div>
              <div class="col-md-12 col-sm-12  form-group">
                <div class="dx-viewport demo-container">
                  <div id="data-grid-demo">
                    <div id="gridContainerDetail">
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-12 col-sm-12  form-group">
                <h3><center>Tujuan Tagihan</center></h3>
                <button class="btn btn-primary">Tambah Siswa</button>
              </div>
              <div class="col-md-12 col-sm-12  form-group">
                <div class="dx-viewport demo-container">
                  <div id="data-grid-demo">
                    <div id="gridContainerSiswa">
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
</div>
<!-- /page content -->

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Modal Jenis Tagihan</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="post_" data-parsley-validate class="form-horizontal form-label-left">
          <div class="item form-group">
            <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Jenis Tagihan <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 ">
              <input type="text" name="NamaTagihan" id="NamaTagihan" required="" placeholder="Nama Jenis Tagihan" class="form-control ">
              <input type="hidden" name="KodeTagihan" id="KodeTagihan">
              <input type="hidden" name="formtype" id="formtype" value="add">
            </div>
          </div>

          <div class="item form-group">
            <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Jenis Tagihan <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 ">
              <select class="form-control " name="KodePosKeuangan" id="KodePosKeuangan">
                <option value="">Pilih Pos Keuangan</option>
                <?php
                  $rs = $this->ModelsExecuteMaster->GetData('tposkeuangan')->result();

                  foreach ($rs as $key) {
                    echo "<option value = '".$key->KodePosKeuangan."'>".$key->NamaPos."</option>";
                  }
                ?>
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
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>
<script type="text/javascript">
  $(function () {
        $(document).ready(function () {
          var where_field = '';
          var where_value = '';
          var table = 'users';

          $.ajax({
            type: "post",
            url: "<?=base_url()?>C_JenisTagihan/Read",
            data: {'id':''},
            dataType: "json",
            success: function (response) {
              bindGridSiswa(response.data);
              bindGridDetail(response.data);
            }
          });

          $('#NoTransaksi').tooltip({'trigger':'hover', 'title': 'Nomor Transaksi'});
          $('#TglTransaksi').tooltip({'trigger':'hover', 'title': 'Tanggal Transaksi'});
        });
        $('#post_').submit(function (e) {
          $('#btn_Save').text('Tunggu Sebentar.....');
          $('#btn_Save').attr('disabled',true);

          e.preventDefault();
          var me = $(this);

          $.ajax({
                type    :'post',
                url     : '<?=base_url()?>C_JenisTagihan/CRUD',
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
    function GetData(id) {
      var where_field = 'id';
      var where_value = id;
      var table = 'users';
      $.ajax({
            type: "post",
            url: "<?=base_url()?>C_JenisTagihan/Read",
            data: {'KodeTagihan':id},
            dataType: "json",
            success: function (response) {
              $.each(response.data,function (k,v) {
                console.log(v.KelompokUsaha);
                // $('#KodePenyakit').val(v.KodePenyakit).change;
                $('#KodeTagihan').val(v.KodeTagihan);
                $('#NamaTagihan').val(v.NamaTagihan);
                $('#KodePosKeuangan').val(v.KodePosKeuangan).change();
                // $('#Nilai').val(v.Nilai);

                $('#formtype').val("edit");

                $('#modal_').modal('show');
              });
            }
          });
    }
    function bindGridSiswa(data) {

      $("#gridContainerSiswa").dxDataGrid({
        allowColumnResizing: true,
            dataSource: data,
            keyExpr: "KodeTagihan",
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
                allowAdding:false,
                allowUpdating: false,
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
                enabled: false,
                fileName: "Daftar Jenis Tagihan"
            },
            columns: [
                {
                    dataField: "NamaTagihan",
                    caption: "No. Induk Siswa",
                    allowEditing:false
                },
                {
                    dataField: "KodePosKeuangan",
                    caption: "Nama Siswa",
                    allowEditing:false
                },
                {
                    dataField: "NamaPos",
                    caption: "Kelas/Jurusan",
                    allowEditing:false
                },
            ],
            onEditingStart: function(e) {
                GetData(e.data.KodeTagihan);
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
              id = e.data.KodeTagihan;
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
                      url     : '<?=base_url()?>C_JenisTagihan/CRUD',
                      data    : {'KodeTagihan':id,'formtype':'delete'},
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

    function bindGridDetail(data) {

      $("#gridContainerDetail").dxDataGrid({
        allowColumnResizing: true,
            dataSource: data,
            keyExpr: "KodeTagihan",
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
                allowUpdating: false,
                allowDeleting: true,
                texts: {
                    confirmDeleteMessage: ''  
                }
            },
            searchPanel: {
                visible: false,
                width: 240,
                placeholder: "Search..."
            },
            export: {
                enabled: false,
                fileName: "Daftar Jenis Tagihan"
            },
            columns: [
                {
                    dataField: "NamaTagihan",
                    caption: "Kode Tagihan",
                    allowEditing:false
                },
                {
                    dataField: "KodePosKeuangan",
                    caption: "Nama Tagihan",
                    allowEditing:false
                },
                {
                    dataField: "NamaPos",
                    caption: "Jumlah Tagihan",
                    allowEditing:false
                },
            ],
            onEditingStart: function(e) {
                GetData(e.data.KodeTagihan);
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
              id = e.data.KodeTagihan;
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
                      url     : '<?=base_url()?>C_JenisTagihan/CRUD',
                      data    : {'KodeTagihan':id,'formtype':'delete'},
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