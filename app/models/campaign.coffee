`import Ember from 'ember';`
`import DS from 'ember-data';`

CampaignModel = DS.Model.extend
  title:                    DS.attr()
  content:                  DS.attr()
  kind:                     DS.attr()
  approved:                 DS.attr()
  targets_count:            DS.attr()
  failures_count:           DS.attr()
  returned_visitors_count:  DS.attr()

  location:  DS.belongsTo('location')

`export default CampaignModel;`
