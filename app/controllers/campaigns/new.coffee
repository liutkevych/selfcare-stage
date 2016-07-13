`import Ember from 'ember';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')
  kind: 'sms'

  symbolsLeft: Ember.computed 'model.message.length', ->
    contentLength = @get('model.message.length')
    if contentLength
      160 - contentLength
    else
      160

  actions:
    create: ->
      @get('currentUser.me').then (me) =>
        @store.findRecord('customer', me.data.id).then (customer) =>
          newCampaign = @get('model')
          newCampaign.set 'kind', @get('kind')
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
      @set 'kind', newKind
      if newKind == 'email'
        CKEDITOR.replace 'campaign-content'

`export default CampaignsNewController;`
