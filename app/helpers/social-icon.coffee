`import Ember from 'ember'`

# This function receives the params `params, hash`
socialIcon = (params) ->
  kind = params[0]
  Ember.String.htmlSafe "<i class=\"fa fa-#{kind}\">"

SocialIconHelper = Ember.Helper.helper socialIcon

`export { socialIcon }`

`export default SocialIconHelper`
