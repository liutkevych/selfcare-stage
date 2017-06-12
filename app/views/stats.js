import Ember from 'ember';

let StatsView = Ember.Component.extend({
  classNames: ['stats'],

  didRender() {
    $('.side-menu li').removeClass('active');
    return $('.side-menu li[route="stats"]').addClass('active');
  }
});

export default StatsView;
