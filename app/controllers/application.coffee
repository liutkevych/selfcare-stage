`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')

  actions:
    toggleSideMenu: ->
      $('.side-menu').animate
        width: 'toggle'
      , 128

    selectLocation: (value) ->
      @set 'locationId', value

    selectSideMenuItem: (e) ->
      $target = $(e.target)
      route = $target.attr 'route'
      $('.side-menu li').removeClass 'active'
      $target.addClass 'active'
      @transitionToRoute route

`export default ApplicationController;`
