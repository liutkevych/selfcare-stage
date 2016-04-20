`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'social-info', 'Integration | Component | social info', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{social-info}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#social-info}}
      template block text
    {{/social-info}}
  """

  assert.equal @$().text().trim(), 'template block text'
