import Ember from 'ember';
import UnauthenticatedRouteMixin from 'ember-simple-auth/mixins/unauthenticated-route-mixin';

let SignInRoute = Ember.Route.extend(UnauthenticatedRouteMixin);

export default SignInRoute;
