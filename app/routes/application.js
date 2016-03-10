import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

var ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, {
  session: Ember.inject.service(),

  actions: {
    invalidateSession: function() {
      this.get('session').invalidate();
    }
  }
});

export default ApplicationRoute;
