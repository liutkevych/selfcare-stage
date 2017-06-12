import Ember from 'ember';

let CampaignsEditController = Ember.Controller.extend({
  currentUser: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),

  symbolsLeft: Ember.computed('newCampaign.message.length', function() {
    let messageLength = this.get('newCampaign.message.length');
    if (messageLength) {
      return 160 - messageLength;
    } else {
      return 160;
    }
  }),

  actions: {
    update() {
      let campaign = this.get('model');
      let kind = this.get('model.kind');
      if (kind === 'email') {
        campaign.set('message', CKEDITOR.instances['campaign-content'].getData());
      }
      campaign.set('location', this.store.peekRecord('location', this.get('locationId')));
      campaign.save().then(() => {
        return this.transitionToRoute('campaigns.index');
      });
      return false;
    },

    selectTargetsFilter(e) {
      return this.set('model.targets_filters', [e]);
    }
  }});

export default CampaignsEditController;
