`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'data-chart', 'Integration | Component | data chart', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{data-chart}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#data-chart}}
      template block text
    {{/data-chart}}
  """

  assert.equal @$().text().trim(), 'template block text'
