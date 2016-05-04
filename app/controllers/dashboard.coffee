`import Ember from 'ember';`
`import moment from 'moment';`

DashboardController = Ember.Controller.extend
  startTime: moment().subtract(30, 'days').toDate()
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

  presenceDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'date', 'Date'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Sessions'

    rows = []
    Object.keys(data).forEach (date) ->
      rows.push [new Date(date), data[date]['visits'], data[date]['sessions']]

    dataTable.addRows rows
    dataTable

  presenceChartOptions: (data) ->
      height: 400
      hAxis:
        gridlines:
          count: Object.keys(data).length / 2

  platforms: Ember.computed 'location_id', ->
    @store.queryRecord 'stat',
      name: 'platforms'

  platformsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Platform'
    dataTable.addColumn 'number', 'Visits'

    rows = []
    Object.keys(data).forEach (platform) ->
      rows.push [platform, data[platform]]

    dataTable.addRows rows
    dataTable

  platformsChartOptions: (data) ->
      height: 300

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
