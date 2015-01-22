require 'hammerjs'
require 'angular'
require 'angular-animate'
require 'angular-sanitize'
require 'angular-aria'
require 'angular-material/angular-material'
require 'angular-ui-router'
require 'ionic/js/ionic'
require 'ionic/js/ionic-angular'

require 'underscore'
require 'restangular'
require 'wp-api-angularjs'

# Style entry point
require './scss/bootstrap'

# Create namespace
window.WPHC = {}

module.exports = app = angular.module 'wordpress-hybrid-client', [
  'ionic'
  'ngMaterial'
  'ui.router'
  'wp-api-angularjs'
  require('./home/home.module').name
]

app.config ($stateProvider) ->
    $stateProvider
    .state 'public',
    url: "/public"
    abstract: true
    template: require "./views/menu"
    controller: "WPHCMainController as main"

app.config (WpApiProvider, CONF) ->
    RestangularProvider = WpApiProvider.getRestangularProvider()
    RestangularProvider.setBaseUrl(CONF.ApiBaseUrl)

app.controller 'WPHCMainController', require "./main.controller"

config = require "../config"

app.constant 'CONF', angular.extend config, WPHC.config || {}
