`import DS from 'ember-data';`

CustomerModel = DS.Model.extend
  campaigns: DS.hasMany('campaign')

`export default CustomerModel;`
