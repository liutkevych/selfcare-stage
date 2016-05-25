`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampainsEditRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.findRecord 'campain', params.id

`export default CampainsEditRoute;`
