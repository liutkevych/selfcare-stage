`import Ember from 'ember';`
`import ENV from 'simplify-selfcare/config/environment';`

CampaignsIndexController = Ember.Controller.extend
  session: Ember.inject.service()
  applicationController: Ember.inject.controller('application')

  campaigns: Ember.computed 'applicationController.locationId', ->
    locationId = @get 'applicationController.locationId'
    return unless locationId

    @store.query 'campaign',
      location_id: locationId

  actions:
    delete: (campaign) ->
      campaign.destroyRecord()

`export default CampaignsIndexController;`
