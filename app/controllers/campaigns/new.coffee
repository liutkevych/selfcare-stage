`import Ember from 'ember';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')
  kind: 'sms'

  symbolsLeft: Ember.computed 'model.content.length', ->
    contentLength = @get('model.content.length')
    if contentLength
      160 - contentLength
    else
      160

  actions:
    create: ->
      @get('currentUser.me').then (me) =>
        @store.findRecord('customer', me.data.id).then (customer) =>
          newCampaign = @get('model')
          newCampaign.set 'customer', customer
          newCampaign.set 'kind', @get('kind')
          newCampaign.set 'location', @store.peekRecord('location', @get('locationId'))
          newCampaign.save().then =>
            @transitionToRoute('campaigns.index')

      return false

    changeKind: (e) ->
      $('.btn-group .btn').removeClass('active')
      $target = $(e.target)
      $target.addClass('active')
      @set 'kind', $target.attr('kind')

`export default CampaignsNewController;`
