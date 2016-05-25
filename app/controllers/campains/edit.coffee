`import Ember from 'ember';`

CampainsEditController = Ember.Controller.extend
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

    update: ->
      @get('model').save().then =>
        @transitionToRoute('campains.index')
      false

`export default CampainsEditController;`
