`import Ember from 'ember'`

CampaignsController = Ember.Controller.extend
  actions:
    selectTargetsFilter: (e) ->
      @set 'targetsFilters', [e]

`export default CampaignsController;`
