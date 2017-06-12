import Ember from 'ember';

// This function receives the params `params, hash`
let socialIcon = function(params) {
  let kind = params[0];
  return Ember.String.htmlSafe(`<i class=\"fa fa-${kind}\">`);
};

let SocialIconHelper = Ember.Helper.helper(socialIcon);

export { socialIcon };

export default SocialIconHelper;
