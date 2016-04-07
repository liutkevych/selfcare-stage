DashboardController = Ember.Controller.extend
  session: Ember.inject.service('session')

  stats: Ember.computed 'location_id', ->
    return unless @get('location_id')
    console.log('request')
    @store.queryRecord 'stats',
      name: 'visits'
      options:
        location_id: @get('location_id')
    , ->
      console.log('response')

  actions:
    selectLocation: (value) ->
      @set 'location_id', value

`export default DashboardController;`
