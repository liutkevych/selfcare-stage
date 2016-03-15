SignInController = Em.Controller.extend
  session: Ember.inject.service('session'),
  email: 'example@email.com'

  actions:
    signIn: ->
      @get('session').authenticate(
        'authenticator:devise',
        @get('email'),
        @get('password'),
      ).then =>
        # console.log @get('session.data.authenticated')
        @transitionToRoute('dashboard')
      , ->
        console.error 'Failed to authenticate'

`export default SignInController;`
