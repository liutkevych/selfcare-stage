`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampainsNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

  model: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @store.findAll('location').then (result) =>
        resolve @store.createRecord('campain',
          location: result.get('firstObject')
        )

  deactivate: ->
    @controllerFor('campains.new').get('model').deleteRecord()

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'locations', @store.findAll 'location'

`export default CampainsNewRoute;`
