`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

DashboardRoute = Em.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service('session')

  model: ->
    @store.findAll('visit').catch (reason) ->
      console.error 'Failed to retrieve visits data from the server'

`export default DashboardRoute;`
