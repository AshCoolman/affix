###*
 * _Without doing anything drastic_, this object lets you wire fixtures to test specs at _test definition time_. It works well with testing frameworks that use fluid APIs (like mocha or Jasmine).
 *
 * Practically speaking, this module gives you a configurable way to `bind` functions that on occasion is more expressive than the regular `Function.prototype.bind` syntax.
 *
 * It was originally used for keyhole refactoring of some large test files, thus it is super-simple and non-invasive.
 *
 *
 * 
 * e.g.
 *
 * the-test.fixtures.coffee:
 * 
 *     module.exports =
 *         beforeEach: 'What is the answer to everything?'
 *         'should equal the answer to everything':
 *             input: [40, 2]
 *             expected: 42
 *     
 * 
 * the-test.spec.coffee:
 *     
 * 
 *     fixtures = require "#{dirname}/in-is-out.fixtures"
 *    
 *     should = require "should"
 *     affix = require("affix") fixtures
 *
 *     
 *     describe 'GET /v2/websites/:website_id/sales/kpi', =>
 *         beforeEach affix.bindSet 'beforeEach', (done) ->
 *             console.log @fixture
 *             done()
 *         
 *         it affix.set('should be the answer to everything'), affix.bind (done) ->
 *             { input, expected } = @fixture
 *             actual = input[0] + input[1]
 *             actual.should.be.exactly expected
 *
###
module.exports = (fixtures) ->

    if 'undefined, number, string, boolean'.indexOf(typeof fixtures) isnt -1
        throw new Error "Expecting non-primative fixtures argument, instead got #{fixtures}"

    fixture = null
    fixtureKey = null


    ###*
     * Set the fixture data that `set` points to
     * 
     * @param  {Object} obj the object whose key values are bound to `this.fixture`
    ###
    config = (obj) =>
        fixtures = obj


    ###*
     * Sets the "cursor" to the wanted fixture, and returns the key unmutated.
     * It takes one input, pipes uses the input to do (unmutating work) and for output
     * 
     * Note: This is a  "T-pipe" function, ( analogy to the T-shaped plumbing pipe )
     * 
     * @param  {[type]} key [Piped]
     * @return {[type]}      [description]
    ###
    set = (key) =>
        fixtureKey = key
        key

    ###*
     * `bind` test fixture data to test function so it is available via `this.fixture`
     * 
     * @param  {Function} fn Statements that make assertions (using the test framework)
     * @return {Function}      Input function, bound to the active fixture
    ###
    bind = (fn) =>
        fn.bind fixture: fixtures[fixtureKey]


    ###*
     * Convieniance function. `set` and `bind` in one
     *
     * @param  {String} key     Optional: Key to sets the "cursor" to the wanted fixture (else falls back to last set)
     * @param  {Function} fn Statements that make assertions (using the test framework)
     * @return {Function}      Input function, bound to the active fixture
    ###
    setBind = (key, fn) =>
        set key
        bind fn

    { set, bind, setBind, config }