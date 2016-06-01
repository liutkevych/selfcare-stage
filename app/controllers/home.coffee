`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

HomeController = Ember.Controller.extend
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias 'applicationController.locationId'
  session: Ember.inject.service()

  lastCampain: Ember.computed 'locationId', ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
        headers = {}
        headers[headerName] = headerValue
        locationId = @get('locationId')
        return unless locationId

        Ember.$.ajax
          url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campains/last"
          headers: headers
          data:
            location_id: locationId
          success: (id) =>
            lastCampain = @store.find('campain', id)
            @set 'lastCampain', lastCampain
            resolve(lastCampain)
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
      height: 500
      hAxis:
        gridlines:
          count: 12
      colors: ['2B86C7', '94C2E3']

  actions:
    toggleQuery: (id) ->
      $("##{id}").slideToggle(128)

`export default HomeController;`
