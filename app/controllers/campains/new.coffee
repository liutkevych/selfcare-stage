`import Ember from 'ember';`

CampainsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()

  symbolsLeft: Ember.computed 'newCampain.message.length', ->
    messageLength = @get('newCampain.message.length')
    if messageLength
      160 - messageLength
    else
      160

  actions:
    selectLocation: (id) ->
      location = @store.peekRecord 'location', id
      @set 'newCampain.location', location

    create: ->
      @get('currentUser.me').then (me) =>
        @store.findRecord('customer', me.data.id).then (customer) =>
          newCampain = @get('newCampain')
          newCampain.set 'customer', customer
          newCampain.save().then =>
            @transitionToRoute('campains.index')

      return false

`export default CampainsNewController;`
