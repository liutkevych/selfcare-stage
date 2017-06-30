import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['segmentation-filter'],
  genderFilterValue: null,
  ageMinValue: null,
  ageMaxValue: null,
  campaignsFilter: Ember.computed('genderFilterValue', 'ageMinValue', 'ageMaxValue', () => {
    let genderFilterValue = this.get('genderFilterValue');
    let ageMinValue = this.get('ageMinValue');
    let ageMaxValue = this.get('ageMaxValue');
    // return REQUST TO API
    // return this.store.query('')
  }),
  /*
    URL: /api/v1/campaignsfilter?gender=male&age=two
    return this.store.query('campaigns', {
      age: ageFilterValue,
      gender: genderFilterValue
    })

  */
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
      this.set('genderFilterValue', targetValue);
      console.log(targetValue);
    }
  }
});
