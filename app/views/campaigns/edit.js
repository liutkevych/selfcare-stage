import Ember from 'ember';

let CampaignsEditView = Ember.Component.extend({
  classNames: ['campaigns-edit'],

  didRender() {
    let kind = $('#campaign-kind').val();
    if (kind === 'email') {
      CKEDITOR.replace('campaign-content');
    }

    $('.side-menu li').removeClass('active');
    return $('.side-menu li[route="campaigns"]').addClass('active');
  }
});

export default CampaignsEditView;
