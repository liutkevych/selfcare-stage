`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampaingsIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll 'campaing'

`export default CampaingsIndexRoute;`
