`import Ember from 'ember'`

GoogleChartsService = Ember.Service.extend
  loaded: false

  init: ->
    google.charts.load 'current',
      packages: ['corechart']
    google.charts.setOnLoadCallback =>
      @set 'loaded', true
      @get('onLoad')()

`export default GoogleChartsService`
