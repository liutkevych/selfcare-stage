`import DS from 'ember-data';`

TaskModel = DS.Model.extend
  phone:     DS.attr()
  attempt:   DS.attr()
  completed: DS.attr()
  campain:   DS.belongsTo('campain')

`export default TaskModel;`
