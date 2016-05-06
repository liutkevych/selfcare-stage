`import Ember from 'ember'`

VisitorsController = Ember.Controller.extend
  location_id: Ember.computed 'model', ->
    @get 'model.firstObject.id'

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default VisitorsController;`
