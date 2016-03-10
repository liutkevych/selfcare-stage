SignInController = Em.Controller.extend
  session: Ember.inject.service(),

  actions:
    signIn: ->
      console.log 'signing in...'
      @get('session').authenticate(
        'authenticator:devise',
        @get('name'),
        @get('password')
      )

`export default SignInController;`
