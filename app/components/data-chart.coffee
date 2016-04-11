`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  googleCharts: Ember.inject.service('google-charts')
  empty: Ember.computed 'chartData', ->
    @get('chartData.total') == 0

  chart: Ember.computed 'googleCharts.loaded', 'chartData', 'showMenu', ->

    $element = $('.chart')
    return if !@get('chartData') || !@get('googleCharts.loaded')

    chartData = []
    perDay = @get('chartData.per_day')
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

    console.log('here')
    new google.visualization.ColumnChart($element[0]).draw(data, options)


`export default DataChartComponent`
