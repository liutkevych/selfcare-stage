/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    API_VERSION: 'v1',
    contentSecurityPolicy: {
      'default-src': ["'none'"],
      'script-src':  ["'self'"],
      'font-src':    ["'self'"],
      'connect-src': ["'self'"],
      'img-src':     ["'self'"],
      'style-src':   ["'self'"],
      'media-src':   ["'self'"]
    },
    modulePrefix: 'simplify-selfcare',
    environment: environment,
    baseURL: '/',
    locationType: 'auto',
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;
    ENV.SERVER_URL = 'https://localhost:3000'
    ENV.contentSecurityPolicy['connect-src'][0] += "https://localhost:3000";
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.SERVER_URL = 'https://openwifi.simp.no'
    ENV.contentSecurityPolicy['connect-src'][0] += "https://openwifi.simp.no";
  }

  if (environment === 'staging') {
    ENV.SERVER_URL = 'https://simplify-stage.herokuapp.com'
    ENV.contentSecurityPolicy['connect-src'][0] += "https://simplify-stage.herokuapp.com";
  }

  ENV['ember-simple-auth'] = {
    authenticationRoute: 'sign-in'
  }

  return ENV;
};
