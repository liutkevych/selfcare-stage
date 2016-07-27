`import Ember from 'ember';`
`import DS from 'ember-data';`

CampaignModel = DS.Model.extend
  title:                    DS.attr()
  message:                  DS.attr()
  kind:                     DS.attr()
  approved:                 DS.attr()
  targets_count:            DS.attr()
  targets_filters:          DS.attr()
  failures_count:           DS.attr()
  returned_visitors_count:  DS.attr()

  isEmail: Ember.computed 'kind', ->
    @get('kind') == 'email'

  isSms: Ember.computed 'kind', ->
    @get('kind') == 'sms'

  location:  DS.belongsTo('location')

`export default CampaignModel;`
