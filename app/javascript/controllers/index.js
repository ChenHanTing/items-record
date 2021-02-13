// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
// 動態讀取結尾為 _controller 的檔案
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))