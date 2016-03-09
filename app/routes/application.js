import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

var ApplicationRoute = Em.Route.extend(ApplicationRouteMixin, {
  actions: {
    invalidateSession: function() {
      this.get('session').invalidate();
    }
  }
});

export default ApplicationRoute;
