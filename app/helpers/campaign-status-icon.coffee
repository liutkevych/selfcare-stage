`import Ember from 'ember'`

# This function receives the params `params, hash`
campaignStatusIcon = (params) ->
  switch params[0]
    when 'pending' then Ember.String.htmlSafe '<i class="fa fa-clock-o" title="Pending">'
    when 'approved' then Ember.String.htmlSafe '<i class="fa fa-check-circle" title="Approved">'
    when 'rejected' then Ember.String.htmlSafe '<i class="fa fa-warning" title="Rejected">'
    else Ember.String.htmlSafe '<i class="fa fa-question-circle" title="Unknown">'

CampaignStatusIconHelper = Ember.Helper.helper campaignStatusIcon

`export { campaignStatusIcon }`

`export default CampaignStatusIconHelper`
