`import Ember from 'ember';`
`import moment from 'moment';`

DashboardController = Ember.Controller.extend
  startTime: moment().subtract(1, 'months').toDate()
  endTime: new Date()

  anyPresence: Ember.computed 'presence.id', ->
    presence = @get 'presence.details.total'
    presence && (presence.visits > 0 || presence.sessions > 0)

  presence: Ember.computed 'location_id', 'startTime', 'endTime', ->
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
