ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')

  actions:
    toggleMenu: ->
      $('.menu').animate
        width: 'toggle'
      , 128

`export default ApplicationController;`
