`import Ember from 'ember'`

eq = (params) ->
  return params[0] == params[1]

EqHelper = Ember.Helper.helper eq

`export { eq }`
`export default EqHelper`
