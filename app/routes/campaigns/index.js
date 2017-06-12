import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';
import ENV from 'simplify-selfcare/config/environment';

let CampaignsIndexRoute = Ember.Route.extend(AuthenticatedRouteMixin, {
  activate() {
    let locationId = this.controllerFor('application').get('locationId');
    this.controllerFor('application').set('locationId', 0);
    return this.controllerFor('application').set('locationId', locationId);
  }
}
);

export default CampaignsIndexRoute;
