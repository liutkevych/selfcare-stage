`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

VisitorsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll('location')

`export default VisitorsRoute;`
