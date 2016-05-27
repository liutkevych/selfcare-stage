`import Ember from 'ember';`
`import moment from 'moment';`

HomeController = Ember.Controller.extend
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias 'applicationController.locationId'

  yearPresenceLoading: Ember.computed 'yearPresence.content', 'yearPresence.id', ->
    @get('yearPresence.content') == null

  signinsLoading: Ember.computed 'signins.content', 'signins.id', ->
    @get('signins.content') == null

  platformsLoading: Ember.computed 'platforms.content', 'platforms.id', ->
    @get('platforms.content') == null

  yearPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'yearPresence'
      options:
        location_id: locationId

  yearPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'date', 'Date'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (date) ->
      rows.push [new Date(date), data[date]['visits'], data[date]['sessions']]

    dataTable.addRows rows
    dataTable

  yearPresenceOptions: (data) ->
      height: 500
      hAxis:
        gridlines:
          count: 12

  platforms: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'platforms'
      options:
        location_id: locationId

  platformsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Platform'
    dataTable.addColumn 'number', 'Visits'

    rows = []
    Object.keys(data).forEach (platform) ->
      rows.push ["#{platform}: #{data[platform].count} (#{data[platform].persentage}%)", data[platform].count]

    dataTable.addRows rows
    dataTable

  pieChartOptions: (data) ->
      height: 200
      tooltip:
        text: 'none'
      chartArea:
        height: '90%'
        width: '100%'
      legend:
        alignment: 'center'

  signins: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'signins'
      options:
        location_id: locationId

  signinsDataFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push ["#{source}: #{data[source].count} (#{data[source].persentage}%)", data[source].count]

    dataTable.addRows rows
    dataTable

  actions:
    toggleQuery: (id) ->
      $("##{id}").slideToggle(128)

`export default HomeController;`
