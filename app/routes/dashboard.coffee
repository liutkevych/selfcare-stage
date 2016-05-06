`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

DashboardRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll('location')

`export default DashboardRoute;`
