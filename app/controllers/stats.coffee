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
      height: 450
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
      height: 520
      tooltip:
        text: 'none'
      chartArea:
        height: '90%'
        width: '90%'
      legend:
        alignment: 'center'
      pieHole: 0.5
      colors: ["#0E2341", "#2B85C6", "#559DD1", "#95C2E2", "#D5E7F4", "FFFFFF"]

  gendersChartOptions: (data) ->
      height: 450
      tooltip:
        text: 'none'
      chartArea:
        height: '90%'
        width: '90%'
      legend:
        alignment: 'center'
      pieHole: 0.5
      colors: ["#2B85C6", "#D5E7F4"]

  signinsFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push ["#{source}: #{data[source].count} (#{data[source].persentage}%)", data[source].count]

    dataTable.addRows rows
    dataTable

  visitors: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'visitors'
      options:
        location_id: @get('locationId')

`export default StatsController;`
