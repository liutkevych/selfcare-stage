`import Ember from 'ember';`
`import config from './config/environment';`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route 'sign-in'
  @route 'sign-out'

  @route 'dashboard',
    path: '/'

  @route 'visitors', ->
    @route 'emails'
    @route 'phones'

  @route 'campaings', ->
    @route 'new'

`export default Router;`
