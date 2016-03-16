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
        currentUser = @store.createRecord(
          'customer',
          @get('session.data.authenticated.data')
        )
        @set('session.data.authenticated.data', currentUser)
        @transitionToRoute('dashboard')
      , ->
        console.error 'Failed to authenticate'

`export default SignInController;`
