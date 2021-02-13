require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

import 'assets/javascripts/sb-admin-2.min.js'
import 'assets/stylesheets/sb-admin-2.min.css'

import '@fortawesome/fontawesome-free/js/all'
import '@fortawesome/fontawesome-free/css/all.css'

// 使用 stimulus
import 'controllers';
// 使用 dataTable
require('datatables.net')
require('datatables.net-bs4')
require("datatables.net-bs4/css/dataTables.bootstrap4.min.css")
