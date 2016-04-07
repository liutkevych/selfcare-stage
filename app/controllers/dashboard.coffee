DashboardController = Ember.Controller.extend
  session: Ember.inject.service('session')

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
