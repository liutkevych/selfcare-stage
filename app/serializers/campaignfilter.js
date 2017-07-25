import JSONSerializer from 'ember-data/serializers/json';

export default JSONSerializer.extend({
  normalizeFindRecordResponse(store, type, payload) {
    // console.log('payload',payload);
    return {
      data: {
        id: payload.location_id,
        type: type.campaignfilter,
        attributes: {
          locationId: payload.location_id,
          kind: payload.kind,
          gender: payload.gender,
          max_age: payload.max_age,
          min_age: payload.min_age,
          times_visited: payload.times_visited,
          date_number: payload.date_number,
          date_type: payload.date_type,
          targets_count: payload.targets_count,
          total_count: payload.total_count
        }
      }
    }
  }
});
