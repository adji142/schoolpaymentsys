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
            <h2>Buku Kas</h2>
            <div class="clearfix"></div>
          </div>

          <div class="x_content">
            <div class="row">
              <div class="col-md-3 col-sm-12  form-group">
                Tgl Awal
                <input type="date" id="FromDate" name="FromDate" class="form-control">
              </div>
              <div class="col-md-3 col-sm-12  form-group">
                Tgl Akhir
                <input type="date" id="ToDate" name="ToDate" class="form-control">
              </div>

              <div class="col-md-4 col-sm-12  form-group">
                <!-- <input type="text" placeholder="NIK / Nama" class="form-control"> -->
                <br>
                <button class="btn btn-primary" id="btSearch">Cari Data</button>
                <a class="btn btn-danger" href="<?php echo base_url().'addtagihan' ?>">Tambah Data</a>
              </div>
              <div class="col-md-12 col-sm-12  form-group">
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
</div>
<!-- /page content -->
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>
<script type="text/javascript">
  $(function () {
    $(document).ready(function () {
      getData()
    });
    $('.close').click(function() {
      location.reload();
    });
    $('#btSearch').click(function () {
      getData();
    });

    function getData() {
      $.ajax({
        type: "post",
        url: "<?=base_url()?>C_BukuKas/Read",
        data: {
          'FromDate':$('#FromDate').val(),
          'ToDate':$('#ToDate').val()
        },
        dataType: "json",
        success: function (response) {
          // bindGrid(response.data);
          // console.log(response.data);
          var items_data=[];
          var SaldoAwal = 0;
          var SaldoAkhir = 0;
          for (var i = 0; i < response.data.length; i++) {
            // Things[i]
            var arr = {};
            if (response.data[i]["KodeAkun"] == "99") {
              SaldoAwal = response.data[i]["SaldoAwal"];
              SaldoAkhir += Number(SaldoAwal) + Number(response.data[i]["Pemasukan"]) - Number(response.data[i]["Pengeluaran"])
              arr = {
                Reff : response.data[i]["Reff"],
                SaldoAwal : SaldoAwal,
                Pemasukan : response.data[i]["Pemasukan"],
                Pengeluaran : response.data[i]["Pengeluaran"],
                Saldo     : SaldoAkhir
              }
            }
            else{
              // console.log();
              SaldoAkhir += Number(SaldoAwal) + Number(response.data[i]["Pemasukan"]) - Number(response.data[i]["Pengeluaran"])
              arr = {
                Reff : response.data[i]["Reff"],
                SaldoAwal : response.data[i]["SaldoAwal"],
                Pemasukan : response.data[i]["Pemasukan"],
                Pengeluaran : response.data[i]["Pengeluaran"],
                Saldo     : SaldoAkhir
              }
            }
            // console.log()
            items_data.push(arr);
          }
          console.log(items_data);
        }
      });
    }
    function bindGrid(data) {

      $("#gridContainer").dxDataGrid({
        allowColumnResizing: true,
            dataSource: data,
            keyExpr: "NoTransaksi",
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
            editing: {
                mode: "row",
                allowAdding:false,
                allowUpdating: false,
                allowDeleting: false,
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
            selection: {
              mode: 'single',
            },
            columns: [
                {
                    dataField: "KodeAkun",
                    caption: "Kode Akun",
                    allowEditing:false
                },
                {
                    dataField: "NamaPos",
                    caption: "Nama Akun",
                    allowEditing:false
                },
                {
                    dataField: "Reff",
                    caption: "Reff",
                    allowEditing:false
                },
                {
                    dataField: "TglTransaksi",
                    caption: "Tgl. Transaksi",
                    allowEditing:false
                },
                {
                    dataField: "Keterangan",
                    caption: "Keterangan",
                    allowEditing:false
                },
                {
                    dataField: "SaldoAwal",
                    caption: "Saldo Awal",
                    allowEditing:false
                },
                {
                    dataField: "Pemasukan",
                    caption: "Pemasukan",
                    allowEditing:false
                },
                {
                    dataField: "Pengeluaran",
                    caption: "Pengeluaran",
                    allowEditing:false
                },
                {
                    dataField: "Saldo",
                    caption: "Saldo",
                    allowEditing:false
                },
            ],
            onSelectionChanged(selectedItems) {
              const data = selectedItems.selectedRowsData[0];
              if (data) {
                $.ajax({
                  type: "post",
                  url: "<?=base_url()?>C_TagihanSiswa/ReadDetail",
                  async: false,
                  data: {
                    'NoTransaksi':data.NoTransaksi
                  },
                  dataType: "json",
                  success: function (response) {
                    var items_data = [];

                    for (var i = 0; i < response.data.length; i++) {
                      var arr ={
                          NoTransaksi     : response.data[i].NoTransaksi,
                          LineNumber      : response.data[i].LineNumber,
                          KodeItemTagihan : response.data[i].KodeItemTagihan,
                          NamaItemTagihan : response.data[i].NamaItemTagihan,
                          JumlahTagihan   : ThousandSparator(response.data[i].JumlahTagihan)
                      }
                      items_data.push(arr);
                    }
                    bindGridDetail(items_data);
                  }
                });
              }
            },
        });

        // add dx-toolbar-after
        // $('.dx-toolbar-after').append('Tambah Alat untuk di pinjam ');
    }

    function ThousandSparator(nStr) {
      nStr += '';
      var x = nStr.split('.');
      var x1 = x[0];
      var x2 = x.length > 1 ? '.' + x[1] : '';
      var rgx = /(\d+)(\d{3})/;
      while (rgx.test(x1)) {
          x1 = x1.replace(rgx, '$1' + ',' + '$2');
      }
      return x1 + x2;
  }
  });
</script>