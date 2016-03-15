`import DS from 'ember-data';`
`import ENV from 'simplify-selfcare/config/environment';`

ApplicationAdapter = DS.JSONAPIAdapter.extend
  namespace: 'api/v1'
  host: ENV.SERVER_URL

`export default ApplicationAdapter;`

