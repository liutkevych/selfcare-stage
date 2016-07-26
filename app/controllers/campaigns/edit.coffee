`import Ember from 'ember';`

CampaignsEditController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')

  symbolsLeft: Ember.computed 'newCampaign.message.length', ->
    messageLength = @get('newCampaign.message.length')
    if messageLength
      160 - messageLength
    else
      160

  actions:
    selectLocation: (id) ->
      location = @store.peekRecord 'location', id
      @set 'newCampaign.location', location

    update: ->
      campaign = @get('model')
      kind = @get 'model.kind'
      if kind == 'email'
        campaign.set 'message', CKEDITOR.instances['campaign-content'].getData()
      campaign.set 'location', @store.peekRecord('location', @get('locationId'))
      campaign.save().then =>
        @transitionToRoute('campaigns.index')
      false

`export default CampaignsEditController;`
