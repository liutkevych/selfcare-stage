`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

HomeController = Ember.Controller.extend
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias 'applicationController.locationId'
  session: Ember.inject.service()

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
        $('#total-count').text(response.total)
        $('#emails').text(response.emails)
        $('#phone-numbers').text(response.phone_numbers)

  lastCampaign: Ember.computed 'locationId', ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
        headers = {}
        headers[headerName] = headerValue
        locationId = @get('locationId')
        return unless locationId

        Ember.$.ajax
          url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campaigns/last"
          headers: headers
          data:
            location_id: locationId
          success: (id) =>
            if id
              lastCampaign = @store.find('campaign', id)
              @set 'lastCampaign', lastCampaign
              resolve(lastCampaign)
            else
              resolve(null)
          error: (reason) ->
            reject reason

  yearPresence: Ember.computed 'locationId', ->
    locationId = @get('locationId')
    return unless locationId

    @store.queryRecord 'stat',
      name: 'yearPresence'
      options:
        location_id: @get('locationId')

  yearPresenceFormatter: (data) ->
    dataTable = new google.visualization.DataTable()
    dataTable.addColumn 'string', 'Month'
    dataTable.addColumn 'number', 'Visits'
    dataTable.addColumn 'number', 'Signins'

    rows = []
    Object.keys(data['per_month']).forEach (date) ->
      rows.push [date, data['per_month'][date]['v'], data['per_month'][date]['s']]

    dataTable.addRows rows
    dataTable

  yearPresenceOptions: (data) ->
    vAxisGridsCount = if data['max'] < 5 then data['max'] + 1 else 5

    {
      title: 'Number of visits/sign ins per month'
      titleTextStyle:
        color: "#333333"
        fontName: "Roboto"
        fontSize: 20
      height: 600
      vAxis:
        baselineColor: '#DDDDDD'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
        textPosition: 'in'
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
        gridlines:
          count: 12
      chartArea:
        height: '70%'
        width: '80%'
      colors: ['#3486CA', '#AEDCFD']
      legend:
        position: 'top'
        textStyle:
          color: "#777777"
          fontName: "Roboto"
          fontSize: 14
    }

`export default HomeController;`
