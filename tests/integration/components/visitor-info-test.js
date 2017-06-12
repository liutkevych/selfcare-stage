import { test, moduleForComponent } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('visitor-info', 'Integration | Component | visitor info', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(2);

  // Set any properties with @set 'myProperty', 'value'
  // Handle any actions with @on 'myAction', (val) ->

  this.render(hbs("{{visitor-info}}"));

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs(`\
{{#visitor-info}}
  template block text
{{/visitor-info}}\
`
  )
  );

  return assert.equal(this.$().text().trim(), 'template block text');
});
