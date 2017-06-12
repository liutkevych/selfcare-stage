import Ember from 'ember';

let GoogleChartsService = Ember.Service.extend({
  loaded: false,
  onLoad: [],

  init() {
    google.charts.load('current',
      {packages: ['corechart']});
    return google.charts.setOnLoadCallback(() => {
      this.set('loaded', true);
      return this.get('onLoad').forEach(onLoadCallback => onLoadCallback());
    });
  }
});

export default GoogleChartsService;
