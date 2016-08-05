`import Ember from 'ember'`

CampaignsNewView = Ember.Component.extend
  classNames: ['campaigns-new']

  didRender: ->
    $('.side-menu li').removeClass('active')
    $('.side-menu li[route="campaigns"]').addClass('active')

`export default CampaignsNewView`
