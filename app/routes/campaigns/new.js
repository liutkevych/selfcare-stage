import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let CampaignsNewRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  session: Ember.inject.service(),

  // locationId: 146,
  // kind: 'sms',
  // gender: 'all',
  // max_age: '100',
  // min_age: '0',
  // times_visited: '0',
  // date_number: '1',
  // date_type: 'months',


  model() {
    return this.store.createRecord('campaign');
    // return Ember.computed('locationId',
    //                       'kind',
    //                       'gender',
    //                       'max_age',
    //                       'min_age',
    //                       'times_visited',
    //                       'date_number',
    //                       'date_type', function () {
    //   let locationId = this.get('locationId');
    //   let kind = this.get('kind');
    //   let gender = this.get('gender');
    //   let max_age = this.get('max_age');
    //   let min_age = this.get('min_age');
    //   let times_visited = this.get('times_visited');
    //   let date_number = this.get('date_number');
    //   let date_type = this.get('date_type');
    //   return this.store.query('campaignfilter', {
    //     locationId: locationId,
    //     kind: kind,
    //     gender: gender,
    //     max_age: max_age,
    //     min_age: min_age,
    //     times_visited: times_visited,
    //     date_number: date_number,
    //     date_type:date_type
    //   })
    // }).then((data) =>{
    //   console.log(data);
    // })
  }

});

export default CampaignsNewRoute;
