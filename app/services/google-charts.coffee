`import Ember from 'ember'`

GoogleChartsService = Ember.Service.extend
  loaded: false
  onLoad: []

  init: ->
    google.charts.load 'current',
      packages: ['corechart']
    google.charts.setOnLoadCallback =>
      @set 'loaded', true
      @get('onLoad').forEach (onLoadCallback) ->
        onLoadCallback()

`export default GoogleChartsService`
