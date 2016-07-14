`import Ember from 'ember'`

HomeView = Ember.Component.extend
  classNames: ['home']

  didRender: ->
    $('.side-menu li').removeClass('active')
    $('.side-menu li[route="home"]').addClass('active')

`export default HomeView`
