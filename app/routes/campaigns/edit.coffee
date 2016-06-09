`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampaignsEditRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.findRecord 'campaign', params.id

`export default CampaignsEditRoute;`
