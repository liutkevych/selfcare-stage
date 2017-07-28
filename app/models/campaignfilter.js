import DS from 'ember-data';
import Ember from 'ember';


export default DS.Model.extend({
  locationId:               DS.attr(),
  kind:                     DS.attr(),
  gender:                   DS.attr(),
  max_age:                  DS.attr(),
  min_age:                  DS.attr(),
  times_visited:            DS.attr(),
  date_number:              DS.attr(),
  date_type:                DS.attr(),
  targetscount:            DS.attr(),
  totalcount:              DS.attr()
});
