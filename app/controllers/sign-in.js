import Ember from 'ember';

let SignInController = Em.Controller.extend({
  session: Ember.inject.service('session'),
  applicationController: Ember.inject.controller('application'),
  error: null,

  actions: {
    signIn() {
      return this.get('session').authenticate(
        'authenticator:devise',
        this.get('email'),
        this.get('password')
      ).then(() => {
        return this.store.findAll('location').then(locations => {
          this.get('applicationController').set('locations', locations);
          this.get('applicationController').set('locationId', locations.get('firstObject.id'));
          return this.transitionToRoute('home');
        });
      }
      , error => {
        return this.set('error', error);
      });
    }
  }
});

export default SignInController;
