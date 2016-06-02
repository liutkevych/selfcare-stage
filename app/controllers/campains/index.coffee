`import Ember from 'ember';`

CampainsIndexController = Ember.Controller.extend
  loading: Ember.computed 'model', ->
    @get('model.content') == null

  limit: true

  actions:
    delete: (campain) ->
      campain.destroyRecord()

`export default CampainsIndexController;`
