import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let CampaignsNewController = Ember.Controller.extend({
  currentUser: Ember.inject.service(),
  applicationController: Ember.inject.controller('application'),
  // locationId: Ember.computed.alias('applicationController.locationId'),
  locationId: Ember.computed('applicationController.locationId', function() {
    return this.get('applicationController.locationId');
  }),
  session: Ember.inject.service(),


  kind: 'sms',
  gender: 'all',
  max_age: '100',
  min_age: '0',
  times_visited: '1',
  date_number: '6',
  date_type: 'months',
  targetscount: '',
  totalcount: '',
  isDisabled: false,

  targetCounter: Ember.computed('locationId',
                                'kind',
                                'gender',
                                'max_age',
                                'min_age',
                                'times_visited',
                                'date_number',
                                'targetscount',
                                'totalcount',
                                'date_type', function () {
    let locationId = this.get('locationId');
    if (locationId) {
      let kind = this.get('kind');
      let gender = this.get('gender');
      let max_age = this.get('max_age');
      let min_age = this.get('min_age');
      let times_visited = this.get('times_visited');
      let date_number = this.get('date_number');
      let date_type = this.get('date_type');
      let targetscount = this.get('targetscount');
      let totalcount = this.get('totalcount');
      let model = this.get('model');




      model.setProperties({
        location_id: locationId,
        kind: kind,
        gender: gender,
        max_age: max_age,
        min_age: min_age,
        times_visited: times_visited,
        date_number: date_number,
        date_type: date_type,
        // targetscount: targetscount,
        // totalcount: totalcount

      });
      // console.log('Hey from controller1=======>');
      return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;
        let locationId = this.get('locationId');

        if (!locationId) { return; }
        return Ember.$.ajax({
          type: "GET",
          url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaignfilters?location_id=`+locationId+`&gender=` + gender
                +`&kind=`+kind+`&min_age=`+min_age +`&max_age=`+ max_age + `&times_visited=`+ times_visited
                + `&date_number=` + date_number + `&date_type=` + date_type, headers
        }).then(response => {
          let targetscount = this.get('targetscount');
          let totalcount = this.get('totalcount');
          // console.log(response.targets_count);
            // return this.set('targets_count', response.targets_count);
              this.set('totalcount', response.total_count);
              this.set('targetscount', response.targets_count);
        })
      })
      // return this.store.query('campaignfilter', {
      //   location_id: locationId,
      //   kind: kind,
      //   gender: gender,
      //   max_age: max_age,
      //   min_age: min_age,
      //   times_visited: times_visited,
      //   date_number: date_number,
      //   date_type:date_type
      // })



      // .then(data => {
      //   console.log(data);
      //   return
      //     this.set('targets_count', data.targets_count);
      //     this.set('total_count', data.total_count);
      //
      // });
    }

  }),

// // this make query to api/v1/campaigns/targets/:locatioId and as response get all the data from location
//   fetchTargetsCount: Ember.observer('model.targets_filters', 'locationId', 'model.kind', function() {
//     let locationId = this.get('locationId');
//     if (!locationId) { return; }
//
//     return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
//       let headers = {};
//       headers[headerName] = headerValue;
//       let locationId = this.get('locationId');
//       if (!locationId) { return; }
//
//       return Ember.$.ajax({
//         url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/targets/${locationId}`,
//         headers}).then(response => {
//         return this.set('targets', response);
//       });
//     });
//   }),
//
//   targetsCount: Ember.computed('model.targets_filters', 'targets', function() {
//     let filter = this.get('model.targets_filters.firstObject');
//     let targets = this.get('targets');
//     if (!targets) { return; }
//
//     return {
//       actual: this.get('targets')[this.get('model.kind')][filter].length,
//       total: this.get('targets')[this.get('model.kind')]['all'].length
//     };
// }),

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
      let model = this.get('model');
      let totalcount = this.get('targetsCounter.total');
      model.set('total_count', totalcount);
      let targetscount = this.get('targetsCounter.targetscount');
      model.set('targetscount', targetscount);
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
      this.set('kind', newKind);
      this.set('model.kind', newKind);
      if (newKind !== 'sms') {
        return CKEDITOR.replace('campaign-content');
      } else if ((newKind === 'sms') && ($('#cke_campaign-content').length > 0)) {
        return CKEDITOR.instances['campaign-content'].destroy();
      }
    },

    changeGender(event) {
      let filterGender = Ember.$('.gender').val();
      this.set('gender', filterGender);
    },

    changeAgeMin(event) {
      let ageMin = Ember.$('.age_min').val();
      this.set('min_age', ageMin);
    },

    changeAgeMax(event) {
      let ageMax = Ember.$('.age_max').val();
      this.set('max_age', ageMax);
    },

    changeTimesVisited(event) {
      let times = Ember.$('.timesVisited').val();
      this.set('times_visited', times);
    },

    changeDateNumber(event) {
      let dateNamber = Ember.$('.dateNamber').val();
      this.set('date_number', dateNamber);
    },

    changeDateType(event) {
      let dateType = Ember.$('.dateType').val();
      this.set('date_type', dateType);
    },

    makeDisabled () {
      this.set('isDisabled', true);
    },

    makeActive() {
      this.set('isDisabled', false);
    }

    // changeFilter(event) {
    //   // event.preventDefault();
    //   // event.stopPropagation();
    //   let model = this.get('model');
    //   let locationId = this.get('locationId');
    //   let kind = this.get('model.kind');
    //
    //
    //   let filterGender = Ember.$('.gender').val();
    //   this.set('gender', filterGender);
    //
    //   let ageMin = this.get('filterAgeMin')();
    //   this.set('min_age', ageMin);
    //
    //   let ageMax = this.get('filterAgeMax')();
    //   this.set('max_age', ageMax);
    //
    //   let times = this.get('timesVisited')();
    //   this.set('times_visited', times);
    //
    //   let dateNamber = this.get('dateNamber')();
    //   this.set('date_number', dateNamber);
    //
    //   let dateType = Ember.$('#dateType').val();
    //   this.set('date_type', dateType);
    //
    //
    //
    //   let authorization = this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
    //     let headers = {};
    //     headers[headerName] = headerValue;
    //     let locationId = this.get('locationId');
    //     if (!locationId) { return; }
    //     return Ember.$.ajax({
    //       type: "GET",
    //       url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/filters?location_id=`+locationId+`&gender=` + filterGender
    //             +`&kind=`+kind+`&min_age=`+ageMin +`&max_age=`+ ageMax + `&times_visited=`+ times
    //             + `&date_number=` + dateNamber + `&date_type=` + dateType, headers
    //     }).then(response => {
    //        this.set('targetsCount.total', response.total_count);
    //        this.set('targetsCount.actual', response.targets_count);
    //     });
    //   });
    // },



  }});

export default CampaignsNewController;
