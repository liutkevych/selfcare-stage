`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsNewController = Ember.Controller.extend
  currentUser: Ember.inject.service()
  applicationController: Ember.inject.controller('application')
  locationId: Ember.computed.alias('applicationController.locationId')
  session: Ember.inject.service()

  fetchTargetsCount: Ember.observer 'model.targets_filters', 'locationId', 'model.kind', ->
    locationId = @get('locationId')
    return unless locationId

    @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue

      Ember.$.ajax
        url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campaigns/targets/#{locationId}"
        headers: headers
      .then (response) =>
        @set 'targets', response

  targetsCount: Ember.computed 'model.targets_filters', 'targets', ->
    filter = @get('model.targets_filters.firstObject')
    targets = @get 'targets'
    return unless targets

    {
      actual: @get('targets')[@get('model.kind')][filter].length,
      total: @get('targets')[@get('model.kind')]['all'].length
    }

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
