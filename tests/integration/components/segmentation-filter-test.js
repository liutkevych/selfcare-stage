import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('segmentation-filter', 'Integration | Component | segmentation filter', {
  integration: true
});

test('it renders', function(assert) {

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{segmentation-filter}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#segmentation-filter}}
      template block text
    {{/segmentation-filter}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
