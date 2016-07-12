`import Ember from 'ember'`

CampaignsEditView = Ember.Component.extend
  classNames: ['campaigns-edit']

  didRender: ->
    kind = $('#campaign-kind').val()
    if kind == 'email'
      CKEDITOR.replace 'campaign-content'

`export default CampaignsEditView`
