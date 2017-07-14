import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let CampaignsNewController = Ember.Controller.extend({
  currentUser: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),
  session: Ember.inject.service(),

// this make query to api/v1/campaigns/targets/:locatioId and as response get all the data from location
  fetchTargetsCount: Ember.observer('model.targets_filters', 'locationId', 'model.kind', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
      let headers = {};
      headers[headerName] = headerValue;
      let locationId = this.get('locationId');
      if (!locationId) { return; }

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
  //
  // filterKind: [],
  // filterLocationId: [],
  // filterAgeMin: [],
  // filterAgeMax: [],
  // filterGender: [],
  //
  // filterQueryComputed: Ember.computed('filterKind', 'filterLocationId', 'filterAgeMin', 'filterAgeMax', 'filterGender', () => {
  //   let filterKind = this.get('filterKind');
  //   let filterLocationId = this.get('filterLocationId');
  //   let filterAgeMin = this.get('filterAgeMin');
  //   let filterAgeMax = this.get('filterAgeMax');
  //   let filterGender = this.get('filterGender');
  //     return this.store.query('filters', {
  //       location_id: filterLocationId,
  //       gender: filterGender,
  //       kind: filterKind,
  //       min_age: filterAgeMin,
  //       max_age: filterAgeMax
  //     });
  // }),

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

    hideLoyialSettings() {
      this.toggleProperty('isLoyial');
    },

    changeFilter(event) {
      // event.preventDefault();
      // event.stopPropagation();
      let filterAgeMin = function() {
        let ageMin = Ember.$('.age_min').val();
        return ageMin ? ageMin : 0;
      };
      let filterAgeMax = function() {
        let ageMax = Ember.$('.age_max').val();
        return ageMax ? ageMax : 100;
      };
      let filterGender = Ember.$('.gender').val();
      let locationId = this.get('locationId');
      let kind = this.get('model.kind');
      // console.log(kind + ' - ' + locationId + ' - ' + filterGender + ' - ' + filterAgeMin() + ' - ' + filterAgeMax());
      let authorization = this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;
        let locationId = this.get('locationId');
        if (!locationId) { return; }
        // console.log(headers);
        return Ember.$.ajax({
          type: "GET",
          url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/filters?location_id=`+locationId+`&gender=` +filterGender
                +`&kind=`+kind+`&min_age=`+filterAgeMin() +`&max_age=`+ filterAgeMax(),headers
        }).then(response => {
          // let targets = {};
          // console.log(response);
          console.log(response.targets_count + ' / ' + response.total_count);
           return this.set('model.usersCountAll', response.total_count).then(this.set('model.usersCountActual', response.targets_count));
        });
      });
    },



  }});

export default CampaignsNewController;
