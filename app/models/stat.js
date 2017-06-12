import DS from 'ember-data';

let StatModel = DS.Model.extend({
  name: DS.attr(),
  details: DS.attr()
});

export default StatModel;
