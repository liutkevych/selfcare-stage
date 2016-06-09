`import Ember from 'ember';`

CampaignsEditController = Ember.Controller.extend
  currentUser: Ember.inject.service()

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
      @get('model').save().then =>
        @transitionToRoute('campaigns.index')
      false

`export default CampaignsEditController;`