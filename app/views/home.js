import Ember from 'ember';

let HomeView = Ember.Component.extend({
  classNames: ['home'],

  didRender() {
    $('.side-menu li').removeClass('active');
    return $('.side-menu li[route="home"]').addClass('active');
  }
});

export default HomeView;
