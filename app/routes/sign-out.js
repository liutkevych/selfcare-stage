import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let SignOutRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  session: Ember.inject.service(),

  beforeModel() {
    return this.get('session').invalidate();
  }
}
);

export default SignOutRoute;
