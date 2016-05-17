`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampainsShowRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.findRecord 'campain', params.id

`export default CampainsShowRoute;`
