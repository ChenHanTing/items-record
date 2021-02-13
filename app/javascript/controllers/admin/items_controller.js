import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['status', 'paymentStatus', 'shippingType'];

  initialize() {
    console.log('initialize');
  }

  connect() {
    console.log('connect');
    /* DataTable with server side render */
    let table = this.dataTable();

    // $('#status-select').on('change', () => table.ajax.reload());
    // $('#shipping-type-select').on('change', () => table.ajax.reload());
    // $('#payment-status-select').on('change', () => table.ajax.reload());
  }
  /**
   * dataTable:
   *
   * 參考
   * 1. 使用範例: https://ithelp.ithome.com.tw/articles/10230169
   * 2. FAQ:    http://datatables.club/faqs/
   * 3.
   **/
  dataTable() {
    return $('#items-list').DataTable({
      serverSide: true,
      bStateSave: true,
      bAutoWidth: false,
      searchDelay: 1200,
      responsive: true,
      ordering: false,
      'language': {
        'processing': '處理中...',
        'loadingRecords': '載入中...',
        'lengthMenu': '顯示 _MENU_ 項結果',
        'zeroRecords': '沒有符合的結果',
        'info': '顯示第 _START_ 至 _END_ 項結果，共 _TOTAL_ 項',
        'infoEmpty': '顯示第 0 至 0 項結果，共 0 項',
        'infoFiltered': '(從 _MAX_ 項結果中過濾)',
        'infoPostFix':'',
        'search': '搜尋:',
        'paginate': {
          'first': '第一頁',
          'previous': '上一頁',
          'next': '下一頁',
          'last': '最後一頁'
        },
        'aria': {
          'sortAscending': ': 升冪排列',
          'sortDescending': ': 降冪排列'
        }
      },
      ajax: {
        url: '/admin/items.json',
        data: {
          // 'ransack_search[status_eq]': () => this.statusTarget.value,
          // 'ransack_search[payment_status_eq]': () => this.paymentStatusTarget.value,
          // 'ransack_search[shipping_type_eq]': () => this.shippingTypeTarget.value
        },
      },
      deferRender: true,
      'rowCallback': (row, data) => {
        $('td:eq(6)', row).html(this.showButton(data[6]));
        $('td:eq(7)', row).html(this.editButton(data[7]));
        $('td:eq(8)', row).html(this.deleteButton(data[8]));
      }
    });
  }
  // 細節
  showButton(id) {
    return `<a href='/admin/items/${id}'>Show</a>`
  }
  // 編輯
  editButton(id) {
    return `<a href='/admin/items/${id}/edit'>Edit</a>`
  }
  // 刪除
  deleteButton(id) {
    return `<a data-confirm='Are you sure?' rel='nofollow' 
               data-method='delete' href='/admin/items/${id}'>Destroy</a>`
  }
}
