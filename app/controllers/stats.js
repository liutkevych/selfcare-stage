import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let StatsController = Em.Controller.extend({
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),
  session: Ember.inject.service(),

  monthPresence: Ember.computed('locationId', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.store.queryRecord('stat', {
      name: 'monthPresence',
      options: {
        location_id: this.get('locationId')
      }
    }
    );
  }),

  monthPresenceOptions(data) {
    let vAxisGridsCount = data['max'] < 5 ? data['max'] + 1 : 5;

    return {
      title: 'Sign ins month overview',
      titleTextStyle: {
        color: "#333333",
        fontName: "Roboto",
        fontSize: 20
      },
      height: 450,
      vAxis: {
        baselineColor: '#DDDDDD',
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        },
        textPosition: 'out',
        format: '#',
        gridlines: {
          count: vAxisGridsCount,
          color: '#DDDDDD'
        }
      },
      hAxis: {
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        },
        textPosition: 'out',
        showTextEvery: 2
      },
      chartArea: {
        height: '65%',
        width: '80%'
      },
      colors: ['#3486CA', '#AEDCFD'],
      legend: {
        position: 'top',
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        }
      }
    };
  },

  monthPresenceFormatter(data) {
    let dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Month');
    dataTable.addColumn('number', 'Signins');

    let rows = [];
    Object.keys(data['per_day']).forEach(date => rows.push([date, data['per_day'][date]]));

    dataTable.addRows(rows);
    return dataTable;
  },

  dayPresence: Ember.computed('locationId', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.store.queryRecord('stat', {
      name: 'dayPresence',
      options: {
        location_id: this.get('locationId')
      }
    }
    );
  }),

  dayPresenceOptions(data) {
    let vAxisGridsCount = data['max'] < 5 ? data['max'] + 1 : 5;

    return {
      title: 'Sign ins daily overview',
      titleTextStyle: {
        color: "#333333",
        fontName: "Roboto",
        fontSize: 20
      },
      height: 450,
      vAxis: {
        baselineColor: '#DDDDDD',
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        },
        textPosition: 'out',
        format: '#',
        gridlines: {
          count: vAxisGridsCount,
          color: '#DDDDDD'
        }
      },
      hAxis: {
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        },
        textPosition: 'out',
        showTextEvery: 2
      },
      chartArea: {
        height: '65%',
        width: '80%'
      },
      colors: ['#3486CA', '#AEDCFD'],
      legend: {
        position: 'top',
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        }
      }
    };
  },

  dayPresenceFormatter(data) {
    let dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Hour');
    dataTable.addColumn('number', 'Signins');

    let rows = [];
    Object.keys(data['per_hour']).forEach(date => rows.push([date, data['per_hour'][date]]));

    dataTable.addRows(rows);
    return dataTable;
  },

  signins: Ember.computed('locationId', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.store.queryRecord('stat', {
      name: 'signins',
      options: {
        location_id: locationId
      }
    }
    );
  }),

  pieChartOptions(data) {
      return {
        height: 555,
        tooltip: {
          text: 'none'
        },
        chartArea: {
          width: '75%',
          top: 100,
          bottom: 100
        },
        legend: {
          position: 'top',
          maxLines: 5,
          alignment: 'center'
        },

        pieHole: 0.5,
        colors: ["#0E2341", "#2B85C6", "#559DD1", "#95C2E2", "#D5E7F4", "FFFFFF"]
      };
    },

  genders: Ember.computed('locationId', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.store.queryRecord('stat', {
      name: 'genders',
      options: {
        location_id: locationId
      }
    }
    );
  }),

  gendersChartOptions(data) {
      return {
        height: 450,
        tooltip: {
          text: 'none'
        },
        chartArea: {
          width: '75%',
          top: 100,
          bottom: 100
        },
        legend: {
          position: 'top',
          maxLines: 5,
          alignment: 'center'
        },

        pieHole: 0.5,
        colors: ["#2B85C6", "95C2E2", "#D5E7F4"]
      };
    },

  gendersFormatter(data) {
    let dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Gender');
    dataTable.addColumn('number', 'Percentage');

    let rows = [];
    Object.keys(data).forEach(gender => rows.push([gender.capitalize(), data[gender]]));

    dataTable.addRows(rows);
    return dataTable;
  },

  signinsFormatter(data) {
    let dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Source');
    dataTable.addColumn('number', 'Signins');

    let rows = [];
    Object.keys(data).forEach(source => rows.push([`${source}: ${data[source].count} (${data[source].persentage}%)`, data[source].count]));

    dataTable.addRows(rows);
    return dataTable;
  },

  visitorsStats: Ember.computed('locationId', function() {
    return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
      let headers = {};
      headers[headerName] = headerValue;
      let locationId = this.get('locationId');
      if (!locationId) { return; }

      return Ember.$.ajax({
        url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/locations/${locationId}/stats`,
        headers}).then(response => {
        $('#online').text(response.online);
        $('#loyals').text(response.loyals);
        $('#emails').text(response.emails);
        return $('#phone-numbers').text(response.phone_numbers);
      });
    });
  })
});

export default StatsController;
