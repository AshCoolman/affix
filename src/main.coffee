###*
 * _Without doing anything drastic_, this object lets you wire fixtures to test specs at _test definition time_. It works well with testing frameworks that use fluid APIs (like mocha or Jasmine).
 *
 * It was originally used for keyhole refactoring of some large test files, thus it is super-simple and non-invasive.
 *
 * 
 * e.g.
 *
 * in-is-out.fixtures.coffee:
 * 
 *     module.exports =
 *         'should be the answer to everything':
 *             inp: 40 + 2
 *             out: 42
 *     
 * 
 * in-is-out.spec.coffee:
 *     
 * 
 *     fixtures = require "#{dirname}/in-is-out.fixtures"
 *    
 *     should = require "should"
 *     affix = require("affix") fixtures
 *
 *     
 *     describe 'GET /v2/websites/:website_id/sales/kpi', =>
 *     
 *         it affix.set('should be the answer to everything'), affix.bind (done) ->
 *         
 *             { inp, out } = @fixture
 *             inp.should.be.exactly out
 *
###
module.exports = (fixtures) ->

    if 'undefined, number, string, boolean'.indexOf(typeof fixtures) isnt -1
        throw new Error "Expecting non-primative fixtures argument, instead got #{fixtures}"

    fixture = null

    ###*
     * This is a  "T-pipe" function, ( analogy to the T-shaped plumbing pipe ). It takes one input, pipes the output, but also uses the input to set the "active" fixture.
     * 
     * @param  {[type]} name [Piped]
     * @return {[type]}      [description]
    ###
    set = (name) =>
        console.log 'Affix set:' + name, fixture[name]
        fixture = fixtures[name]
        name

    ###*
     * `bind` test fixture data to test function so it is available `this.fixture`
     * 
     * @param  {Function} fn Statements that make assertions (using the test framework)
     * @return {Function}      Input function, bound to the active fixture
    ###
    bind = (fn) =>
        console.log 'Affix bind'
        fn.bind { fixture }

    { set, bind }