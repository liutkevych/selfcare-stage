`import DS from 'ember-data';`

StatModel = DS.Model.extend
  person:   DS.belongsTo('person')
  location: DS.belongsTo('location')
  details:  DS.attr()

`export default StatModel;`
