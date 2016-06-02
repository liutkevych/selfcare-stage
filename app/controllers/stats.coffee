`import Ember from 'ember'`

StatsController = Em.Controller.extend
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias 'applicationController.locationId'

  monthPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'monthPresence'
      options:
        location_id: @get('locationId')

  monthPresenceOptions: ->
      height: 470
      hAxis:
        gridlines:
          count: 15
      colors: ['2B86C7', '94C2E3']

  monthPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Month'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (date) ->
      rows.push [date, data[date]['v'], data[date]['s']]

    dataTable.addRows rows
    dataTable

  dayPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'dayPresence'
      options:
        location_id: @get('locationId')

  dayPresenceOptions: ->
      height: 450
      hAxis:
        gridlines:
          count: 24
      colors: ['2B86C7', '94C2E3']

  dayPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Hour'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (date) ->
      rows.push [date, data[date]['v'], data[date]['s']]

    dataTable.addRows rows
    dataTable

  signins: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'signins'
      options:
        location_id: @get('locationId')

  pieChartOptions: (data) ->
      height: 450
      tooltip:
        text: 'none'
      chartArea:
        height: '90%'
        width: '90%'
      legend:
        alignment: 'center'
      colors: ['9999FF', '2B86C7', '94C2E3', 'dae6ef', 'EEEEFF']

  signinsFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push ["#{source}: #{data[source].count} (#{data[source].persentage}%)", data[source].count]

    dataTable.addRows rows
    dataTable

  online: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'online'
      options:
        location_id: @get('locationId')

`export default StatsController;`
