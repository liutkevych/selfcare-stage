`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`

VisitorsPhonesController = Ember.Controller.extend
  visitors: Ember.inject.controller()
  session: Ember.inject.service()

  loading: Ember.computed 'phones', ->
    @get('phones') == undefined

  phones: Ember.computed 'model', ->
    @fetchPhones()

  fetchPhones: Ember.observer 'visitors.location_id', ->
    location_id = @get 'visitors.location_id'
    @set 'phones', undefined

    @get('session').authorize('authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue

      Ember.$.ajax
        headers: headers
        url: "#{ENV.SERVER_URL}/api/v1/visitors/phones"
        data:
          location_id: location_id
        success: (result) =>
          @set 'phones', result
    )

`export default VisitorsPhonesController;`
