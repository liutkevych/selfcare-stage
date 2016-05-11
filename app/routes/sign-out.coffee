`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

SignOutRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

  beforeModel: ->
    @get('session').invalidate()


`export default SignOutRoute`;
