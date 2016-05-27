`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  googleCharts: Ember.inject.service('google-charts')
  classNames: ['data-chart']

  anyData: Ember.computed 'model', ->
    model = @get('model')
    return false unless model

    Object.keys(model).length > 0

  renderChart: (context) ->
    model = context.get('model')

    data = context.get('dataFormatter')(model)
    options = context.get('options')(model)

    type = context.get('type')
    container = context.$('.chart-area')[0]

    chart = switch type
      when 'column'
        new google.visualization.ColumnChart(container)
      when 'pie'
        new google.visualization.PieChart(container)

    chart.draw(data, options)

  isReadyToRender: (context) ->
    context.get('model') &&
    context.get('googleCharts.loaded') &&
    context.$('.chart-area') != undefined &&
    context.$('.chart-area').length > 0

  didReceiveAttrs: ->
    @get('renderChart')(this) if @get('isReadyToRender')(this)

  didInsertElement: ->
    @get('renderChart')(this) if @get('isReadyToRender')(this)

  didRender: ->
    @_super()

    @get('renderChart')(this) if @get('isReadyToRender')(this)

    unless @get('googleCharts.loaded')
      onLoad = @get('googleCharts.onLoad')
      onLoad.push =>
        @get('renderChart')(this) if @get('isReadyToRender')(this)

`export default DataChartComponent`
