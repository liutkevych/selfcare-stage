import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let VisitorsPhonesRoute = Ember.Route.extend(AuthenticatedRouteMixin);

export default VisitorsPhonesRoute;
