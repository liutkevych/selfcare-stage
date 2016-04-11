`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

VisitorsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  setupController: (controller, model) ->
    controller.set 'model', model
    @store.findAll('location').then (locations) ->
      controller.set 'locations',  locations
      controller.set 'location_id', locations.get('firstObject.id')

`export default VisitorsRoute;`
