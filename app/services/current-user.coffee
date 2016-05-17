`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`

CurrentUserService = Ember.Service.extend
  session: Ember.inject.service()

  me: Ember.computed 'session.data.authenticated.token', ->
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
        headers = {}
        headers[headerName] = headerValue

        Ember.$.ajax
          url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/me"
          headers: headers
          success: (data) ->
            resolve(data)
          error: (error) ->
            reject(error)



`export default CurrentUserService`
