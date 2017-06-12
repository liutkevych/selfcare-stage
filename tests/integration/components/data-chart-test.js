import { test, moduleForComponent } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('data-chart', 'Integration | Component | data chart', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(2);

  // Set any properties with @set 'myProperty', 'value'
  // Handle any actions with @on 'myAction', (val) ->

  this.render(hbs("{{data-chart}}"));

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs(`\
{{#data-chart}}
  template block text
{{/data-chart}}\
`
  )
  );

  return assert.equal(this.$().text().trim(), 'template block text');
});
