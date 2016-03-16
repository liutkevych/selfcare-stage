DashboardController = Ember.Controller.extend
  session: Ember.inject.service('session')
  actions:
    createUser: ->
      newUser = @store.createRecord 'user',
        firstName: 'Eugene'
      newUser.save()

`export default DashboardController;`
