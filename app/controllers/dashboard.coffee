`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  session: Ember.inject.service('session')

  stats: Ember.computed 'location_id', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'visits'
      options:
        location_id: location_id
        start_time: '29 March 2016 15:10:19 +0300'
    .then (visitsStats) =>
      @set 'stats.visits', visitsStats


  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
