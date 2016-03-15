`import DS from 'ember-data';`

VisitModel = DS.Model.extend
  location_id:     DS.attr()
  access_point_id: DS.attr()
  device_id:       DS.attr()
  created_at:      DS.attr('date')
  updated_at:      DS.attr('date')

`export default VisitModel;`
