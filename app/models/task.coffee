`import DS from 'ember-data';`

TaskModel = DS.Model.extend
  phone:     DS.attr()
  attempt:   DS.attr()
  completed: DS.attr()
  campaign:  DS.belongsTo('campaign')

`export default TaskModel;`
