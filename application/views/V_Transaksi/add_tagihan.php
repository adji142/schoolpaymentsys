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
              <div class="col-md-12 col-sm-12  form-group">
                <button class="btn btn-danger">Simpan</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- /page content -->

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_ItemTagihan">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Modal Item Tagihan</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="dx-viewport demo-container">
          <div id="data-grid-demo">
            <div id="gridLookupItemTagihan">
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary"  id="btSave">Save</button>
        
      </div>

    </div>
  </div>
</div>
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>
<script type="text/javascript">
  $(function () {
    var items_Detail = [];
    var arrSiswa ={
        NIS       : "",
        NamaSiswa : "",
        Kelas     : "",
    }

    var arrDetail ={
        KodeTagihan : "",
        NamaTagihan : "",
        Jumlah      : "",
    }
    $(document).ready(function () {
      bindGridSiswa(arrSiswa);
      bindGridDetail(arrDetail);

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

    $('#btSave').click(function () {
      items_Detail.push(arrDetail);
      bindGridDetail(items_Detail);
      $('#modal_ItemTagihan').modal('toggle');

      var button = $('.dx-link-edit');
      button.click();
    })
    function bindGridLookupTagihan(data) {

      $("#gridLookupItemTagihan").dxDataGrid({
        allowColumnResizing: true,
        dataSource: data,
        keyExpr: "KodeTagihan",
        showBorders: true,
        allowColumnReordering: true,
        allowColumnResizing: true,
        columnAutoWidth: true,
        hoverStateEnabled: true,
        paging: {
          pageSize: 10,
          enabled: true
        },
        pager: {
          visible: true,
          allowedPageSizes: [5, 10, 'all'],
          showPageSizeSelector: true,
          showInfo: true,
          showNavigationButtons: true,
        },
        searchPanel: {
            visible: true,
            width: 240,
            placeholder: "Search..."
        },
        selection: {
          mode: 'single',
          // mode: 'multiple',
        },
        columns: [
          {
              dataField: "KodeTagihan",
              caption: "Kode Tagihan",
              allowEditing:false
          },
          {
              dataField: "NamaTagihan",
              caption: "Nama Jenis Tagihan",
              allowEditing:false
          },
        ],
        onSelectionChanged(selectedItems) {
          const data = selectedItems.selectedRowsData[0];
          if (data) {
            arrDetail ={
                KodeTagihan : data.KodeTagihan,
                NamaTagihan : data.NamaTagihan,
                Jumlah      : 0,
            }
          }
        }
      });

        // add dx-toolbar-after
        // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
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
                dataField: "NIS",
                caption: "No. Induk Siswa",
                allowEditing:false
            },
            {
                dataField: "NamaSiswa",
                caption: "Nama Siswa",
                allowEditing:false
            },
            {
                dataField: "Kelas",
                caption: "Kelas/Jurusan",
                allowEditing:false
            },
        ],
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
            allowUpdating: true,
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
                dataField: "KodeTagihan",
                caption: "Kode Tagihan",
                allowEditing:false
            },
            {
                dataField: "NamaTagihan",
                caption: "Nama Tagihan",
                allowEditing:false
            },
            {
                dataField: "Jumlah",
                caption: "Jumlah Tagihan",
                allowEditing:true
            },
        ],
        onInitNewRow: function(e) {
            // logEvent("InitNewRow");
          $.ajax({
            type: "post",
            url: "<?=base_url()?>C_JenisTagihan/Read",
            data: {'id':''},
            dataType: "json",
            success: function (response) {
              bindGridLookupTagihan(response.data);
              $('#modal_ItemTagihan').modal('show');
            }
          });
        },
        onRowClick: function (rowInfo) {  
          rowInfo.component.editRow(rowInfo.rowIndex);  
        },  
    });

        // add dx-toolbar-after
        // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
    }
  });
</script>