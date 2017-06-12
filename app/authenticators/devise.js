import Devise from 'ember-simple-auth/authenticators/devise';
import ENV from 'simplify-selfcare/config/environment';

let DeviseAuthenticator = Devise.extend({
  serverTokenEndpoint: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/auth/selfcare`,
  resourceName: 'customer'
});

export default DeviseAuthenticator;
