import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let CampaignsEditRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  model(params) {
    return this.store.findRecord('campaign', params.id);
  }
}
);

export default CampaignsEditRoute;
