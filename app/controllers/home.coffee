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
    Object.keys(data).forEach (date) ->
      rows.push [date, data[date]['v'], data[date]['s']]

    dataTable.addRows rows
    dataTable

  yearPresenceOptions: (data) ->
      height: 600
      hAxis:
        gridlines:
          count: 12
      colors: ['2B86C7', '94C2E3']

`export default HomeController;`
