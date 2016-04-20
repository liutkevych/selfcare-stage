`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'visitor-info', 'Integration | Component | visitor info', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{visitor-info}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#visitor-info}}
      template block text
    {{/visitor-info}}
  """

  assert.equal @$().text().trim(), 'template block text'
