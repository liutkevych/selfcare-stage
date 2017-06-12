import Ember from 'ember';
import ENV from 'simplify-selfcare/config/environment';

let HomeController = Ember.Controller.extend({
  applicationController: Ember.inject.controller('application'),
  locationId: Ember.computed.alias('applicationController.locationId'),
  session: Ember.inject.service(),

  visitorsStats: Ember.computed('locationId', function() {
    return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
      let headers = {};
      headers[headerName] = headerValue;
      let locationId = this.get('locationId');
      if (!locationId) { return; }

      return Ember.$.ajax({
        url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/locations/${locationId}/stats`,
        headers}).then(response => {
        $('#total-count').text(response.total);
        $('#emails').text(response.emails);
        return $('#phone-numbers').text(response.phone_numbers);
      });
    });
  }),

  lastCampaign: Ember.computed('locationId', function() {
    return new Ember.RSVP.Promise((resolve, reject) => {
      return this.get('session').authorize('authorizer:devise', (headerName, headerValue) => {
        let headers = {};
        headers[headerName] = headerValue;
        let locationId = this.get('locationId');
        if (!locationId) { return; }

        return Ember.$.ajax({
          url: `${ENV.SERVER_URL}/api/${ENV.API_VERSION}/campaigns/last`,
          headers,
          data: {
            location_id: locationId
          },
          success: id => {
            if (id) {
              let lastCampaign = this.store.find('campaign', id);
              this.set('lastCampaign', lastCampaign);
              return resolve(lastCampaign);
            } else {
              return resolve(null);
            }
          },
          error(reason) {
            return reject(reason);
          }
        });
      });
    });
  }),

  yearPresence: Ember.computed('locationId', function() {
    let locationId = this.get('locationId');
    if (!locationId) { return; }

    return this.store.queryRecord('stat', {
      name: 'yearPresence',
      options: {
        location_id: this.get('locationId')
      }
    }
    );
  }),

  yearPresenceFormatter(data) {
    let dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Month');
    dataTable.addColumn('number', 'Signins');

    let rows = [];
    Object.keys(data['per_month']).forEach(date => rows.push([date, data['per_month'][date]]));

    dataTable.addRows(rows);
    return dataTable;
  },

  yearPresenceOptions(data) {
    let vAxisGridsCount = data['max'] < 5 ? data['max'] + 1 : 5;

    return {
      title: 'Number of sign ins per month',
      titleTextStyle: {
        color: "#333333",
        fontName: "Roboto",
        fontSize: 20
      },
      height: 600,
      vAxis: {
        baselineColor: '#DDDDDD',
        textStyle: {
          color: "#777777",
          fontName: "Roboto",
          fontSize: 14
        },
        textPosition: 'in',
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
        gridlines: {
          count: 12
        }
      },
      chartArea: {
        height: '70%',
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
  }});

export default HomeController;
