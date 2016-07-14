`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

StatsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  activate: ->
    locationId = @controllerFor('application').get('locationId')
    @controllerFor('application').set('locationId', 0)
    @controllerFor('application').set('locationId', locationId)

`export default StatsRoute;`
