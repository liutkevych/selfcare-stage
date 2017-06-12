import Ember from 'ember';

let DataChartComponent = Ember.Component.extend({
  googleCharts: Ember.inject.service('google-charts'),
  classNames: ['data-chart'],

  anyData: Ember.computed('model', function() {
    let model = this.get('model');
    if (!model) { return false; }

    return Object.keys(model).length > 0;
  }),

  renderChart(context) {
    let model = context.get('model');

    let data = context.get('dataFormatter')(model);
    let options = context.get('options')(model);

    let type = context.get('type');
    let container = context.$('.chart-area')[0];

    let chart = (() => { switch (type) {
      case 'column':
        return new google.visualization.ColumnChart(container);
      case 'pie':
        return new google.visualization.PieChart(container);
      case 'line':
        return new google.visualization.LineChart(container);
    } })();

    return chart.draw(data, options);
  },

  isReadyToRender(context) {
    return context.get('model') &&
    context.get('googleCharts.loaded') &&
    (context.$('.chart-area') !== undefined) &&
    (context.$('.chart-area').length > 0);
  },

  didReceiveAttrs() {
    if (this.get('isReadyToRender')(this)) { return this.get('renderChart')(this); }
  },

  didInsertElement() {
    if (this.get('isReadyToRender')(this)) { return this.get('renderChart')(this); }
  },

  didRender() {
    this._super();

    if (this.get('isReadyToRender')(this)) { this.get('renderChart')(this); }

    if (!this.get('googleCharts.loaded')) {
      let onLoad = this.get('googleCharts.onLoad');
      return onLoad.push(() => {
        if (this.get('isReadyToRender')(this)) { return this.get('renderChart')(this); }
      });
    }
  }
});

export default DataChartComponent;
