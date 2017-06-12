import DS from 'ember-data';

let CustomerModel = DS.Model.extend({
  campaigns: DS.hasMany('campaign')});

export default CustomerModel;
