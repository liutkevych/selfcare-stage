ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')
  currentUser: Ember.computed 'session.data.authenticated.data', ->
    @get 'session.data.authenticated.data'

  actions:
    toggleMenu: ->
      $('.menu').animate
        width: 'toggle'
      , 128

`export default ApplicationController;`
