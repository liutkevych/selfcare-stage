`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`

StatsController = Em.Controller.extend
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias 'applicationController.locationId'
  session: Ember.inject.service()

  monthPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'monthPresence'
      options:
        location_id: @get('locationId')

  monthPresenceOptions: (data) ->
    vAxisGridsCount = if data['max'] < 5 then data['max'] + 1 else 5

    {
      title: 'Sign ins month overview'
      titleTextStyle:
        color: "#333333"
        fontName: "Roboto"
        fontSize: 20
      height: 450
      vAxis:
        baselineColor: '#DDDDDD'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
        textPosition: 'out'
        format: '#'
        gridlines:
          count: vAxisGridsCount
          color: '#DDDDDD'
      hAxis:
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
        textPosition: 'out'
        showTextEvery: 2
      chartArea:
        height: '65%'
        width: '80%'
      colors: ['#3486CA', '#AEDCFD']
      legend:
        position: 'top'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
    }

  monthPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Month'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data['per_day']).forEach (date) ->
      rows.push [date, data['per_day'][date]]

    dataTable.addRows rows
    dataTable

  dayPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'dayPresence'
      options:
        location_id: @get('locationId')

  dayPresenceOptions: (data) ->
    vAxisGridsCount = if data['max'] < 5 then data['max'] + 1 else 5

    {
      title: 'Sign ins daily overview'
      titleTextStyle:
        color: "#333333"
        fontName: "Roboto"
        fontSize: 20
      height: 450
      vAxis:
        baselineColor: '#DDDDDD'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
        textPosition: 'out'
        format: '#'
        gridlines:
          count: vAxisGridsCount
          color: '#DDDDDD'
      hAxis:
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
        textPosition: 'out'
        showTextEvery: 2
      chartArea:
        height: '65%'
        width: '80%'
      colors: ['#3486CA', '#AEDCFD']
      legend:
        position: 'top'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
    }

  dayPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Hour'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data['per_hour']).forEach (date) ->
      rows.push [date, data['per_hour'][date]]

    dataTable.addRows rows
    dataTable

  signins: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'signins'
      options:
        location_id: locationId

  pieChartOptions: (data) ->
      height: 570
      tooltip:
        text: 'none'
      chartArea:
        width: '75%'
        top: 100
        bottom: 100
      legend:
        position: 'top'
        maxLines: 5
        alignment: 'center'

      pieHole: 0.5
      colors: ["#0E2341", "#2B85C6", "#559DD1", "#95C2E2", "#D5E7F4", "FFFFFF"]

  genders: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'genders'
      options:
        location_id: locationId

  gendersChartOptions: (data) ->
      height: 450
      tooltip:
        text: 'none'
      chartArea:
        width: '75%'
        top: 100
        bottom: 100
      legend:
        position: 'top'
        maxLines: 5
        alignment: 'center'

      pieHole: 0.5
      colors: ["#2B85C6", "95C2E2", "#D5E7F4"]

  gendersFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Gender'
    dataTable.addColumn 'number', 'Percentage'

    rows = []
    Object.keys(data).forEach (gender) ->
      rows.push [gender.capitalize(), data[gender]]

    dataTable.addRows rows
    dataTable

  signinsFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Source'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data).forEach (source) ->
      rows.push ["#{source}: #{data[source].count} (#{data[source].persentage}%)", data[source].count]

    dataTable.addRows rows
    dataTable

  visitorsStats: Ember.computed 'locationId', ->
    @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue
      locationId = @get('locationId')
      return unless locationId

      Ember.$.ajax
        url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/locations/#{locationId}/stats"
        headers: headers
      .then (response) =>
        $('#online').text(response.online)
        $('#loyals').text(response.loyals)
        $('#emails').text(response.emails)
        $('#phone-numbers').text(response.phone_numbers)

`export default StatsController;`
