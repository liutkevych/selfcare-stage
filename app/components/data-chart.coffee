`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  googleCharts: Ember.inject.service('google-charts')
  chart: Ember.computed 'googleCharts.loaded', 'chartData', ->
    return if !@get('chartData') || !@get('googleCharts.loaded')

    chartData = []
    perDay = @get('chartData')
    Object.keys(perDay).forEach (date) ->
      chartData.push [new Date(date), perDay[date]]
    data = new google.visualization.DataTable()
    data.addColumn('date', 'Date')
    data.addColumn('number', 'Visits count')
    data.addRows(chartData)
    options =
      hAxis:
        gridlines:
          count: chartData.length

    new google.visualization.ColumnChart($('.chart')[0]).draw(data, options)

`export default DataChartComponent`
