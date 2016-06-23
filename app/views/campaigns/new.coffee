`import Ember from 'ember'`

CampaignsNewView = Ember.Component.extend
  classNames: ['campaigns-new']

  didRender: ->
    console.log @$('#campaign-content')

`export default CampaignsNewView`
