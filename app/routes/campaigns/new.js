import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let CampaignsNewRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  session: Ember.inject.service(),

  model() {
    return new Ember.RSVP.Promise((resolve, reject) => {
      return this.store.findAll('location').then(result => {
        return resolve(this.store.createRecord('campaign', {
          location: result.get('firstObject'),
          kind: 'sms',
          targets_filters: ['all']
        }));
      });
    });
  },

  deactivate() {
    return this.controllerFor('campaigns.new').get('model').deleteRecord();
  },

  setupController(controller, model) {
    controller.set('model', model);
    return controller.set('locations', this.store.findAll('location'));
  }
}
);

export default CampaignsNewRoute;
