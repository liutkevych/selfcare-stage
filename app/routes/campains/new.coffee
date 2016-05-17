`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampainsNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.findAll 'location'

  deactivate: ->
    @controllerFor('campains.new').get('newCampain').deleteRecord()

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'newCampain', @store.createRecord('campain',
      location: model.get('firstObject')
    )

`export default CampainsNewRoute;`
