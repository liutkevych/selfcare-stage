import Ember from 'ember';

let CampaignsIndexView = Ember.Component.extend({
  classNames: ['campaigns'],

  didRender() {
    $('.side-menu li').removeClass('active');
    return $('.side-menu li[route="campaigns"]').addClass('active');
  }
});

export default CampaignsIndexView;
