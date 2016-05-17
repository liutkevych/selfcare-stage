`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampainsIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll 'campain'

`export default CampainsIndexRoute;`
