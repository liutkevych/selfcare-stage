import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let CurrentUserService = Ember.Service.extend({
  session: Ember.inject.service(),

  me: Ember.computed('session.data.authenticated.token', function() {
    return new Ember.RSVP.Promise((resolve, reject) => {
      return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;

        return Ember.$.ajax({
          url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/me`,
          headers,
          success(data) {
            return resolve(data);
          },
          error(error) {
            return reject(error);
          }
        });
      });
    });
  })
});



export default CurrentUserService;
