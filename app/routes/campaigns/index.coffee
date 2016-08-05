`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  activate: ->
    locationId = @controllerFor('application').get('locationId')
    @controllerFor('application').set('locationId', 0)
    @controllerFor('application').set('locationId', locationId)

`export default CampaignsIndexRoute;`
