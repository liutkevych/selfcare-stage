`import Ember from 'ember';`

CampaignsIndexController = Ember.Controller.extend
  limit: true

  actions:
    delete: (campaign) ->
      campaign.destroyRecord()

`export default CampaignsIndexController;`
