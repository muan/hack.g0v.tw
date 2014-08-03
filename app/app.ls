# Declare app level module which depends on filters, and services

angular.module('scroll', []).value('$anchorScroll', angular.noop)

angular.module \app <[ui app.templates app.controllers irc.g0v.tw hub.g0v.tw ui.router ui.router.stateHelper]># ui.bootstrap]>
.config <[stateHelperProvider $urlRouterProvider $locationProvider]> ++ (stateHelperProvider, $urlRouterProvider, $locationProvider) ->
  stateHelperProvider
    ..setNestedState do
      name: 'authz'
      url: '/authz/{request}'
      templateUrl: 'partials/authz.html'
      controller: \AuthzCtrl
    ..setNestedState do
      name: 'about'
      url: '/about'
      templateUrl: 'partials/about.html'
    ..setNestedState do
      name: 'projcet-name'
      url: '/project-new'
      templateUrl: 'partials/project.new.html'
      controller: \ProjectCtrl
    ..setNestedState do
      name: 'irc'
      url: '/irc'
      onEnter: ->
        $ \body .addClass \hide-overflow
      onExit: ->
        $ \body .removeClass \hide-overflow
      children:
        name: 'log'
        url: '/log'
    ..setNestedState do
      name: 'project'
      url: '/project'
      templateUrl: 'partials/project.html'
      controller: \ProjectCtrl
      children:
        name: 'detail'
        url: '/{projectName}'
    ..setNestedState do
      name: 'people'
      url: '/people'
      templateUrl: 'partials/people.html'
      controller: \PeopleCtrl
    ..setNestedState do
      name: 'tag'
      url: '/tag/{tag}'
      templateUrl: 'partials/tag.html'
      controller: \TagControl
    ..setNestedState do
      name: 'hack'
      url: '/{hackId:[^/]{1,}}'
      template-url: 'partials/hack.html'
      resolve:
        hackId: <[$stateParams]> ++ (.hackId)
      controller: 'HackFolderCtrl'
      onEnter: ->
        $ \body .addClass \hide-overflow
      onExit: ->
        $ \body .removeClass \hide-overflow
      children:
        * name: 'index'
          url: '/__index'
        * name: 'doc'
          url: '/{docId}'

  $urlRouterProvider
    .otherwise('/g0v-hackath9n')

  $locationProvider.html5Mode true

.run <[$rootScope $state $stateParams $location]> ++ ($rootScope, $state, $stateParams, $location) ->
  $rootScope.$state = $state
  $rootScope.$stateParam = $stateParams
  $rootScope.go = -> $location.path it
  $rootScope._build = require 'config.jsenv' .BUILD
  $rootScope.$on \$stateChangeSuccess (e, {name}) ->
    window?ga? 'send' 'pageview' page: $location.$$url, title: name
  $rootScope.$safeApply = ($scope, fn) ->
    phase = $scope.$root.$$phase
    if (phase is '$apply' || phase is '$digest')
      fn?!
    else
      $scope.$apply fn
