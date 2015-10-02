{ green, white, red, reset } = require 'simple-ansi'

FIXTURE_ONE = test: 1, another: 2
FIXTURE_TWO = test: "abc"

affix = require("../src/main") FIXTURE_ONE
should = require 'should'
it = (label, work) ->
    try
        work()
        console.log "#{green}✔#{white} - #{label}#{reset}"
    catch e
        console.log "#{red}❌#{white} - #{label}: #{red}#{e.message}#{reset}"

fn = -> @fixture

affix.set "test"
fnSetThenBound = affix.bind fn
it "bind correctly after `require` > `set()` > `bind()`", -> fnSetThenBound().should.equal FIXTURE_ONE.test

fnSetAndBound = affix.setBind "another", fn
it "bind correctly changing 'cursor' to `another`", -> fnSetAndBound().should.equal FIXTURE_ONE.another

# Different fixture set, same cursor
affix.config FIXTURE_TWO

fnSetThenBound = affix.bind fn
it "bind correctly after fixture changed", -> (undefined is fnSetThenBound()).should.be.false

affix.set "test"
it "binds `undefined` after cursor changed, but not rebound ", -> (undefined is fnSetThenBound()).should.be.true

fnSetThenBound = affix.bind fn
it "bind value after cursor changed AND rebound", -> fnSetThenBound().should.equal FIXTURE_TWO.test

fnSetAndBound = affix.setBind "test", fn
it "bind correctly after `setBind`", -> fnSetAndBound().should.equal FIXTURE_TWO.test