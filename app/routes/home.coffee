`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

HomeRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll('location')

`export default HomeRoute;`
