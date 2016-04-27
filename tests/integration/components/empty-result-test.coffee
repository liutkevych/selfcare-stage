`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'empty-result', 'Integration | Component | empty result', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{empty-result}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#empty-result}}
      template block text
    {{/empty-result}}
  """

  assert.equal @$().text().trim(), 'template block text'
