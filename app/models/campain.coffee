`import DS from 'ember-data';`

CampainModel = DS.Model.extend
  title:           DS.attr()
  message:         DS.attr()
  status:          DS.attr()
  targets_count:   DS.attr()
  completed_count: DS.attr()
  failed_count:    DS.attr()

  customer:  DS.belongsTo('customer')
  location:  DS.belongsTo('location')

`export default CampainModel;`
