import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let CampaignsNewController = Ember.Controller.extend({
  currentUser: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),
  session: Ember.inject.service(),

//this make query to api/v1/campaigns/targets/:locatioId and as response get all the data from location
  fetchTargetsCount: Ember.observer('model.targets_filters', 'locationId', 'model.kind', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
      let headers = {};
      headers[headerName] = headerValue;

      return Ember.$.ajax({
        url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/targets/${locationId}`,
        headers}).then(response => {
        return this.set('targets', response);
      });
    });
  }),

  targetsCount: Ember.computed('model.targets_filters', 'targets', function() {
    let filter = this.get('model.targets_filters.firstObject');
    let targets = this.get('targets');
    if (!targets) { return; }

    return {
      actual: this.get('targets')[this.get('model.kind')][filter].length,
      total: this.get('targets')[this.get('model.kind')]['all'].length
    };
}),

  symbolsLeft: Ember.computed('model.message.length', function() {
    let contentLength = this.get('model.message.length');
    if (contentLength) {
      return 160 - contentLength;
    } else {
      return 160;
    }
  }),

  actions: {
    create() {
      let newCampaign = this.get('model');
      let kind = this.get('model.kind');
      if (kind !== 'sms') {
        newCampaign.set('message', CKEDITOR.instances['campaign-content'].getData());
      }
      newCampaign.set('location', this.store.peekRecord('location', this.get('locationId')));
      newCampaign.save().then(() => {
        return this.transitionToRoute('campaigns.index');
      });

      return false;
    },

    changeKind(e) {
      $('.btn-group .btn').removeClass('active');
      let $target = $(e.target);
      $target.addClass('active');
      let newKind = $target.attr('kind');
      this.set('model.kind', newKind);
      if (newKind !== 'sms') {
        return CKEDITOR.replace('campaign-content');
      } else if ((newKind === 'sms') && ($('#cke_campaign-content').length > 0)) {
        return CKEDITOR.instances['campaign-content'].destroy();
      }
    },

    selectTargetsFilter(e) {
      return this.set('model.targets_filters', [e]);
    },

    hideLoyialSettings() {
      this.toggleProperty('isLoyial');
    },

    changeMinAge(event) {
      event.preventDefault();
      event.stopPropagation();
      let targetValue = Ember.$(event.target).val();
      this.set('ageMinValue', targetValue);
      console.log(targetValue);
    },

    changeMaxAge(event) {
      event.preventDefault();
      event.stopPropagation();
      let targetValue = Ember.$(event.target).val();
      this.set('ageMaxValue', targetValue);
      console.log(targetValue);
    },

    changeGender(event) {
      event.preventDefault();
      event.stopPropagation();
      let targetValue = Ember.$(event.target).val();
      let model = this.get('model');
      let kind = this.get('model.kind');
      let locationId = this.get('locationId');
      // let genderFilterValue = model.get('gender_type');
      // this.set('genderFilterValue', targetValue);
      // model.set('gender_type', targetValue);
      // this.get('onSave')();
        return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
          let headers = {};
          headers[headerName] = headerValue;
          return Ember.$.ajax({
            type: "GET",
            url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/gender?location_id=`+locationId+`&gender=` +targetValue
                  +`&kind=`+kind+`&min_age=1&max_age=100`
          }).then(console.log("Heey!"))
        });
    },

    save() {
      let model = this.get('model');
      model.save();
    }

  }});

export default CampaignsNewController;
