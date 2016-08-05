`import Ember from 'ember'`

StatsView = Ember.Component.extend
  classNames: ['stats']

  didRender: ->
    $('.side-menu li').removeClass('active')
    $('.side-menu li[route="stats"]').addClass('active')

`export default StatsView`
