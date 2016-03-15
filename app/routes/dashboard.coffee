`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

DashboardRoute = Em.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll('visit')

`export default DashboardRoute;`
