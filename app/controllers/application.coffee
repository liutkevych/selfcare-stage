`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')

  showMenu: false

  actions:
    toggleSideMenu: ->
      $('.side-menu').animate
        width: 'toggle'
      , 128

`export default ApplicationController;`
