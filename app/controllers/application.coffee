`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')

  showMenu: false

  actions:
    toggleMenu: ->
      $('.menu').animate
        width: 'toggle'
      , 128, =>
        @set 'showMenu', !@get('showMenu')

`export default ApplicationController;`
