`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  googleCharts: Ember.inject.service('google-charts')
  classNames: ['data-chart']

  renderChart: (context) ->
    data = []
    model = context.get('model')
    Object.keys(model).forEach (date) ->
      data.push [new Date(date), model[date].visits, model[date].sessions]

    dataTable = new google.visualization.DataTable()
    dataTable.addColumn('date', 'Date')
    dataTable.addColumn('number', 'Visits')
    dataTable.addColumn('number', 'Sessions')
    dataTable.addRows(data)

    options =
      hAxis:
        gridlines:
          count: data.length

    container = $('.chart-area')[0]

    new google.visualization.ColumnChart(container).draw(dataTable, options)

  isReadyToRender: (context) ->
    context.get('model') && context.get('googleCharts.loaded') && $('.chart-area').length > 0

  didReceiveAttrs: ->
    @get('renderChart')(this) if @get('isReadyToRender')(this)

  didRender: ->
    @_super()

    @get('renderChart')(this) if @get('isReadyToRender')(this)

    unless @get('googleCharts.loaded')
      @set 'googleCharts.onLoad', =>
        @get('renderChart')(this) if @get('isReadyToRender')(this)

`export default DataChartComponent`
