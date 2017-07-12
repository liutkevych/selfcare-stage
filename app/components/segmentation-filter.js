import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

export default Ember.Component.extend({
  currentUser: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),
  session: Ember.inject.service(),


  classNames: ['segmentation-filter'],
  campaignsFilter: Ember.computed('genderFilterValue', 'ageMinValue', 'ageMaxValue', () => {
    let genderFilterValue = this.get('genderFilterValue');
    let ageMinValue = this.get('ageMinValue');
    let ageMaxValue = this.get('ageMaxValue');

  }),

  actions: {
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
    }

  }
});
