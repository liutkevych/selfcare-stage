import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

let VisitorsEmailsRoute = Ember.Route.extend(AuthenticatedRouteMixin);

export default VisitorsEmailsRoute;
