`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'gear-spinner', 'Integration | Component | gear spinner', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{gear-spinner}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#gear-spinner}}
      template block text
    {{/gear-spinner}}
  """

  assert.equal @$().text().trim(), 'template block text'
