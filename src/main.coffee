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
     * Sets the "cursor" to the wanted fixture, and returns the name unmutated.
     * 
     * Note: This is a  "T-pipe" function, ( analogy to the T-shaped plumbing pipe ) - it takes one input, pipes uses the input to do (unmutating work) and for output
     * 
     * @param  {[type]} name [Piped]
     * @return {[type]}      [description]
    ###
    set = (name) =>
        fixture = fixtures[name]
        name

    ###*
     * `bind` test fixture data to test function so it is available via `this.fixture`
     * 
     * @param  {Function} fn Statements that make assertions (using the test framework)
     * @return {Function}      Input function, bound to the active fixture
    ###
    bind = (fn) =>
        fn.bind { fixture }


    ###*
     * Convieniance function. `set` and `bind` in one
     *
     * @param  {String} key     Optional: Key to sets the "cursor" to the wanted fixture (else falls back to last set)
     * @param  {Function} fn Statements that make assertions (using the test framework)
     * @return {Function}      Input function, bound to the active fixture
    ###
    setBind = (key, fn) =>
        set arguments[0]
        bind arguments[1]

    { set, bind }