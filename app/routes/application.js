import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

var ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, {
  session: Ember.inject.service('session'),

  setupController: function(controller, model) {
    controller.set('model', model);
    if (this.get('session.isAuthenticated'))
      this.store.findAll('location').then((locations) => {
        controller.set('locations', locations);
        controller.set('locationId', locations.get('firstObject.id'));
      })
  },

  actions: {
    invalidateSession: function() {
      this.get('session').invalidate();
    }
  },

  invalidationSucceeded: function() {
    console.log('invalidated');
  }
});

export default ApplicationRoute;
