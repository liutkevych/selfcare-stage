`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll 'campaign'

  activate: ->
    @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue

      Ember.$.ajax
        headers: headers
        url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campaigns/limit"
        success: (result) =>
          @controllerFor('campaigns.index').set('limit', result)

`export default CampaignsIndexRoute;`
