`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

DashboardRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll('location')

  activate: ->
    @controllerFor('dashboard').set('location_id', 6)

`export default DashboardRoute;`
