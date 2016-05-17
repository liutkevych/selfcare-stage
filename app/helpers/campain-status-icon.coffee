`import Ember from 'ember'`

# This function receives the params `params, hash`
campainStatusIcon = (params) ->
  switch params[0]
    when 'pending' then Ember.String.htmlSafe '<i class="fa fa-clock-o" title="Pending">'
    when 'approved' then Ember.String.htmlSafe '<i class="fa fa-check-circle" title="Approved">'
    when 'rejected' then Ember.String.htmlSafe '<i class="fa fa-warning" title="Rejected">'
    else Ember.String.htmlSafe '<i class="fa fa-question-circle" title="Unknown">'

CampainStatusIconHelper = Ember.Helper.helper campainStatusIcon

`export { campainStatusIcon }`

`export default CampainStatusIconHelper`
