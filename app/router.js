import Ember from 'ember';
import config from './config/environment';

let Router = Ember.Router.extend({
  location: config.locationType});

Router.map(function() {
  this.route('sign-in');
  this.route('sign-out');

  this.route('home',
    {path: '/'});

  this.route('stats');

  return this.route('campaigns', function() {
    this.route('new');
    return this.route('edit',
      {path: '/:id/edit'});
  });
});

export default Router;
