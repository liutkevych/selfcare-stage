import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

var ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, {
  session: Ember.inject.service('session'),

  actions: {
    invalidateSession: function() {
      this.get('session').invalidate();
    }
  },

  sessionAuthenticated: function() {
  }
});

export default ApplicationRoute;
