`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`
`import ENV from 'simplify-selfcare/config/environment';`

CampainsIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll 'campain'

  activate: ->
    @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue

      Ember.$.ajax
        headers: headers
        url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campains/limit"
        success: (result) =>
          @controllerFor('campains.index').set('limit', result)

`export default CampainsIndexRoute;`
