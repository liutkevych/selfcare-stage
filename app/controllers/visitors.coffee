`import Ember from 'ember'`

VisitorsController = Ember.Controller.extend
  visitors: Ember.computed 'location_id', ->
    return unless @get('location_id')
    @store.query 'visitor',
      location_id: @get('location_id')

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default VisitorsController;`
