import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

var ApplicationRoute = Ember.Route.extend(ApplicationRouteMixin, {
  session: Ember.inject.service('session'),

  setupController: function(controller, model) {
    controller.set('model', model);
    controller.set('locations', this.store.findAll('location'));
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
