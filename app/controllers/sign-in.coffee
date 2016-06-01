`import Ember from 'ember'`

SignInController = Em.Controller.extend
  session: Ember.inject.service('session')
  applicationController: Ember.inject.controller('application')
  error: null

  actions:
    signIn: ->
      @get('session').authenticate(
        'authenticator:devise',
        @get('email'),
        @get('password')
      ).then =>
        @store.findAll('location').then (locations) =>
          @get('applicationController').set('locations', locations)
          @get('applicationController').set('locationId', locations.get('firstObject.id'))
          @transitionToRoute('home')
      , (error) =>
        @set 'error', error

`export default SignInController;`
