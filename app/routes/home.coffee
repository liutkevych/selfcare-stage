`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

HomeRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

`export default HomeRoute;`
