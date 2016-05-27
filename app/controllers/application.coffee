`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')

  activate: ->
    @set 'locations', @findAll('location')

  showMenu: false

  actions:
    toggleSideMenu: ->
      $('.side-menu').animate
        width: 'toggle'
      , 128

    selectLocation: (value) ->
      @set 'locationId', value

`export default ApplicationController;`
