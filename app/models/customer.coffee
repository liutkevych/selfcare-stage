`import DS from 'ember-data';`

CustomerModel = DS.Model.extend
  campains: DS.hasMany('campain')

`export default CustomerModel;`
