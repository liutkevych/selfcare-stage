import Ember from 'ember';

let ApplicationController = Ember.Controller.extend({
  session: Ember.inject.service('session'),

  actions: {
    toggleSideMenu() {
      return $('.side-menu').animate(
        {width: 'toggle'}
      , 128);
    },

    selectLocation(value) {
      return this.set('locationId', value);
    },

    selectSideMenuItem(e) {
      let $target = $(e.target);
      let route = $target.attr('route');
      $('.side-menu li').removeClass('active');
      $target.addClass('active');
      return this.transitionToRoute(route);
    }
  }
});

export default ApplicationController;
