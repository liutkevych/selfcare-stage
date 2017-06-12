import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let CampaignsIndexController = Ember.Controller.extend({
  session: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),

  campaigns: Ember.computed('applicationController.locationId', function() {
    let locationId = this.get('applicationController.locationId');
    if (!locationId) { return; }

    return this.store.query('campaign',
      {location_id: locationId});
  }),

  actions: {
    delete(campaign) {
      return campaign.destroyRecord();
    }
  }
});

export default CampaignsIndexController;
