`import Ember from 'ember'`

CampaignsIndexView = Ember.Component.extend
  classNames: ['campaigns']

  didRender: ->
    $('.side-menu li').removeClass('active')
    $('.side-menu li[route="campaigns"]').addClass('active')

`export default CampaignsIndexView`
