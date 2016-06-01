`import Ember from 'ember'`
`import ENV from 'simplify-selfcare/config/environment';`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';`

HomeRoute = Ember.Route.extend AuthenticatedRouteMixin,
  session: Ember.inject.service()

  activate: ->
    @get('session').authorize 'authorizer:devise', (headerName, headerValue) =>
      headers = {}
      headers[headerName] = headerValue

      Ember.$.ajax
        url: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/campains/last"
        headers: headers
        data:
          location_id: @controllerFor('application').get('locationId')
        success: (data) =>
          @controllerFor('home').set('lastCampain', data)

`export default HomeRoute;`
