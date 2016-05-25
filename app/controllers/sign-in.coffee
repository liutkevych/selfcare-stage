`import Ember from 'ember'`

SignInController = Em.Controller.extend
  session: Ember.inject.service('session'),
  email: 'example@email.com'
  error: null

  actions:
    signIn: ->
      @get('session').authenticate(
        'authenticator:devise',
        @get('email'),
        @get('password')
      ).then =>
        @transitionToRoute('home')
      , (error) =>
        @set 'error', error

`export default SignInController;`
