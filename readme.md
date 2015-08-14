# Affix - stick data to your tests

## Intro

_Without doing anything drastic_, this object lets you wire fixtures to test specs at _test definition time_. It works well with testing frameworks that use fluid APIs (like mocha or Jasmine).

It was originally used for keyhole refactoring of some large test files, thus it is super-simple and non-invasive.

## Usage

in-is-out.fixtures.coffee:

    module.exports =
        'should be the answer to everything':
            inp: 40 + 2
            out: 42


in-is-out.spec.coffee:

    fixtures = require "#{dirname}/in-is-out.fixtures"
   
    should = require "should"
    affix = require("affix") fixtures
    
    describe 'GET /v2/websites/:website_id/sales/kpi', =>
    
        it affix.set('should be the answer to everything'), affix.bind (done) ->
        
            { inp, out } = @fixture
            inp.should.be.exactly out