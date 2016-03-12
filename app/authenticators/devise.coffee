`import Devise from 'ember-simple-auth/authenticators/devise';`
`import ENV from 'simplify-selfcare/config/environment';`

DeviseAuthenticator = Devise.extend
  serverTokenEndpoint: "#{ENV.SERVER_URL}/api/#{ENV.API_VERSION}/sessions"

`export default DeviseAuthenticator;`
