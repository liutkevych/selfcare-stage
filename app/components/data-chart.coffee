`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  googleCharts: Ember.inject.service('google-charts')
  classNames: ['data-chart']

  chart: Ember.computed 'googleCharts.loaded', 'model.id', ->
    return if !@get('googleCharts.loaded') || !@get('model.details') || !@get('model.id')

    $element = $('.data-chart')

    chartData = []
    perDay = @get('model.details.per_day')
    Object.keys(perDay).forEach (date) ->
      chartData.push [new Date(date), perDay[date].visits, perDay[date].sessions]

    data = new google.visualization.DataTable()
    data.addColumn('date', 'Date')
    data.addColumn('number', 'Visits')
    data.addColumn('number', 'Sessions')
    data.addRows(chartData)

    options =
      hAxis:
        gridlines:
          count: chartData.length

    new google.visualization.ColumnChart($element[0]).draw(data, options)

`export default DataChartComponent`
