ApplicationController = Ember.Controller.extend
  showMenu: true

  actions:
    toggleMenu: ->
      @set('showMenu', !@get('showMenu'))

`export default ApplicationController;`
