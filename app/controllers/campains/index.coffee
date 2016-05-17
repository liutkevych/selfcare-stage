`import Ember from 'ember';`

CampainsIndexController = Ember.Controller.extend
  loading: Ember.computed 'model', ->
    @get('model.content') == null

`export default CampainsIndexController;`
