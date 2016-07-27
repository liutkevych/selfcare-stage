`import Ember from 'ember';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')

  symbolsLeft: Ember.computed 'model.message.length', ->
    contentLength = @get('model.message.length')
    if contentLength
      160 - contentLength
    else
      160

  actions:
    create: ->
      newCampaign = @get('model')
      kind = @get('model.kind')
      if kind == 'email'
        newCampaign.set 'message', CKEDITOR.instances['campaign-content'].getData()
      newCampaign.set 'location', @store.peekRecord('location', @get('locationId'))
      newCampaign.save().then =>
        @transitionToRoute('campaigns.index')

      return false

    changeKind: (e) ->
      $('.btn-group .btn').removeClass('active')
      $target = $(e.target)
      $target.addClass('active')
      newKind = $target.attr('kind')
      @set 'model.kind', newKind
      if newKind == 'email'
        CKEDITOR.replace 'campaign-content'
      else if newKind == 'sms' && $('#cke_campaign-content').length > 0
        CKEDITOR.instances['campaign-content'].destroy()

    selectTargetsFilter: (e) ->
      @set 'model.targets_filters', [e]

`export default CampaignsNewController;`
