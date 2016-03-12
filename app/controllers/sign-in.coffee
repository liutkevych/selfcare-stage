SignInController = Em.Controller.extend
  session: Ember.inject.service('session'),

  actions:
    signIn: ->
      @get('session').authenticate(
        'authenticator:devise',
        @get('name'),
        @get('password'),
      )

`export default SignInController;`
