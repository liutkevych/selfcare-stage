`import Ember from 'ember';`

CampaignsIndexController = Ember.Controller.extend
  loading: Ember.computed 'model', ->
    @get('model.content') == null

  limit: true

  actions:
    delete: (campaign) ->
      campaign.destroyRecord()

`export default CampaignsIndexController;`
