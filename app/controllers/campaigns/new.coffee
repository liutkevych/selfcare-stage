`import Ember from 'ember';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()

  symbolsLeft: Ember.computed 'model.message.length', ->
    messageLength = @get('model.message.length')
    if messageLength
      160 - messageLength
    else
      160

  actions:
    selectLocation: (id) ->
      location = @store.peekRecord 'location', id
      @set 'model.location', location

    create: ->
      @get('currentUser.me').then (me) =>
        @store.findRecord('customer', me.data.id).then (customer) =>
          newCampaign = @get('model')
          newCampaign.set 'customer', customer
          newCampaign.save().then =>
            @transitionToRoute('campaigns.index')

      return false

`export default CampaignsNewController;`
