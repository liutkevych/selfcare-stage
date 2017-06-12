import DS from 'ember-data';

let PersonModel = DS.Model.extend({
  phone: DS.attr(),
  email: DS.attr()
});

export default PersonModel;
