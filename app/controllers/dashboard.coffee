`import Ember from 'ember';`
`import moment from 'moment';`

DashboardController = Ember.Controller.extend
  applicationController: Ember.inject.controller('application')

  startTime: moment().subtract(1, 'months').toDate()
  endTime: new Date()

  locations: Ember.computed ->
    @store.findAll('location')

  location_id: Ember.computed 'locations.firstObject.id', ->
    @get('locations.firstObject.id')

  stats: Ember.computed 'location_id', 'startTime', 'endTime', ->
    location_id = @get('location_id')
    return unless location_id

    @store.queryRecord 'stat',
      name: 'presence'
      options:
        location_id: location_id
        start_time: @get('startTime')
        end_time: @get('endTime')

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
