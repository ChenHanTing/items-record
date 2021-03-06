const { environment } = require('@rails/webpacker')

// yarn add bootstrap jquery popper.js
const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))

/* 使用絕對路徑 */
const customConfig = require('./custom')
environment.config.merge(customConfig)

module.exports = environment
