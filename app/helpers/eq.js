import Ember from 'ember';

let eq = params => params[0] === params[1];

let EqHelper = Ember.Helper.helper(eq);

export { eq };
export default EqHelper;
