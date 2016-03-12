ApplicationController = Ember.Controller.extend
  showMenu: true
  session: Ember.inject.service('session')

  actions:
    toggleMenu: ->
      @set('showMenu', !@get('showMenu'))

`export default ApplicationController;`
