import Ember from 'ember';
import DS from 'ember-data';

let CampaignModel = DS.Model.extend({
  title:                    DS.attr(),
  subject:                  DS.attr(),
  message:                  DS.attr(),
  kind:                     DS.attr(),
  approved:                 DS.attr(),
  targets_count:            DS.attr(),
  targets_filters:          DS.attr(),
  failures_count:           DS.attr(),
  returned_visitors_count:  DS.attr(),
  locationId:               DS.attr(),
  created:                  DS.attr(),

  createdAt: Ember.computed('created', function() {
    return moment(this.get('created')).format('MMM Do YYYY');
  }),

  isEmail: Ember.computed('kind', function() {
    return this.get('kind') === 'email';
  }),

  isSms: Ember.computed('kind', function() {
    return this.get('kind') === 'sms';
  }),

  notSms: Ember.computed.not('isSms'),

  isPopup: Ember.computed('kind', function() {
    return this.get('kind') === 'popup';
  }),

  location:   DS.belongsTo('location')
});

export default CampaignModel;
