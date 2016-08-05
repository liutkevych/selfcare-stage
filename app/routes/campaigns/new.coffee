`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

CampaignsNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

  model: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @store.findAll('location').then (result) =>
        resolve @store.createRecord('campaign',
          location: result.get('firstObject')
          kind: 'sms',
          targets_filters: ['all']
        )

  deactivate: ->
    @controllerFor('campaigns.new').get('model').deleteRecord()

  setupController: (controller, model) ->
    controller.set 'model', model
    controller.set 'locations', @store.findAll 'location'

`export default CampaignsNewRoute;`
