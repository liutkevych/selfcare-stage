ApplicationController = Ember.Controller.extend
  session: Ember.inject.service('session')
  currentUser: Ember.computed 'session.data.authenticated', ->
    @get 'session.data.authenticated.customer'

  actions:
    toggleMenu: ->
      $('.menu').animate
        width: 'toggle'
      , 128

`export default ApplicationController;`
