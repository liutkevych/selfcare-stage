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

  filterAgeMin() {
    let ageMin = Ember.$('.age_min').val();
    return ageMin ? ageMin : 0;
  },

  filterAgeMax() {
    let ageMax = Ember.$('.age_max').val();
    return ageMax ? ageMax : 100;
  },

  timesVisited() {
    let visits = Ember.$('#timesVisited').val();
    return visits ? visits : 0;
  },

  dateNamber() {
    let number = Ember.$('#dateNamber').val();
    return number ? number : 0;
  },


  actions: {
    create() {
      let model = this.get('model');
      let total_count = this.get('targetsCount.total');
      model.set('total_count', total_count);
      let targets_count = this.get('targetsCount.actual');
      model.set('targets_count', targets_count);
      let kind = this.get('model.kind');
      if (kind !== 'sms') {
        model.set('message', CKEDITOR.instances['campaign-content'].getData());
      }
      model.set('location', this.store.peekRecord('location', this.get('locationId')));
      model.save().then(() => {
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
      let model = this.get('model');
      let locationId = this.get('locationId');
      let kind = this.get('model.kind');


      let filterGender = Ember.$('.gender').val();
      model.set('gender', filterGender);

      let ageMin = this.get('filterAgeMin')();
      model.set('min_age', ageMin);

      let ageMax = this.get('filterAgeMax')();
      model.set('max_age', ageMax);

      let times = this.get('timesVisited')();
      model.set('times_visited', times);

      let dateNamber = this.get('dateNamber')();
      model.set('date_number', dateNamber);

      let dateType = Ember.$('#dateType').val();
      model.set('date_type', dateType);



      let authorization = this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;
        let locationId = this.get('locationId');
        if (!locationId) { return; }
        return Ember.$.ajax({
          type: "GET",
          url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/filters?location_id=`+locationId+`&gender=` + filterGender
                +`&kind=`+kind+`&min_age=`+ageMin +`&max_age=`+ ageMax + `&times_visited=`+ times
                + `&date_number=` + dateNamber + `&date_type=` + dateType, headers
        }).then(response => {
           this.set('targetsCount.total', response.total_count);
           this.set('targetsCount.actual', response.targets_count);
        });
      });
    },



  }});

export default CampaignsNewController;
