`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'stats-panel', 'Integration | Component | stats panel', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{stats-panel}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#stats-panel}}
      template block text
    {{/stats-panel}}
  """

  assert.equal @$().text().trim(), 'template block text'
