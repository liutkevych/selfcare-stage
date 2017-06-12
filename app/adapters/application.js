import DS from 'ember-data';
import ENV from 'simplify-selfcare/config/environment';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';

let ApplicationAdapter = DS.JSONAPIAdapter.extend(DataAdapterMixin, {
  authorizer: 'authorizer:devise',
  namespace: 'api/v1',
  host: ENV.SERVER_URL
}
);

export default ApplicationAdapter;

