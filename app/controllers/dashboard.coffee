`import Ember from 'ember'`

DashboardController = Ember.Controller.extend
  applicationController: Ember.inject.controller('application')

  stats: Ember.computed 'location_id', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'presence'
      options:
        location_id: location_id

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
