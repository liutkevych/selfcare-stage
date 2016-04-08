`import Ember from 'ember'`

DataChartComponent = Ember.Component.extend
  actions:
    refresh: ->
      chartData = []
      perDay = @get('chartData.details.per_day')
      google.charts.load 'current',
        packages: ['corechart']
      google.charts.setOnLoadCallback =>
        Object.keys(perDay).forEach (date) ->
          chartData.push [new Date(date), perDay[date]]
        data = new google.visualization.DataTable()
        data.addColumn('date', 'Date')
        data.addColumn('number', 'Visits count')
        data.addRows(chartData)
        options = {
          hAxis: {
            gridlines: {
              count: chartData.length
            }
          }
        }
        new google.visualization.ColumnChart($('.chart')[0]).draw(data, options)


`export default DataChartComponent`
