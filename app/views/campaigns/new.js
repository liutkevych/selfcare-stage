import Ember from 'ember';

let CampaignsNewView = Ember.Component.extend({
  classNames: ['campaigns-new'],

  didRender() {
    $('.side-menu li').removeClass('active');
    return $('.side-menu li[route="campaigns"]').addClass('active');
  }
});

export default CampaignsNewView;
