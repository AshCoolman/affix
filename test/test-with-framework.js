/**
 * Framework config not included for package dependency minimisation
 *
 * However this was tested with:
 *  "mocha": "^2.1.0"
 *  "should": "4.6.3"
 *
 * If you setup your test packages globally you can run: 
 *     mocha $(find test -iname \"test-with-framework.js\" -exec echo {} \\;)
 * 
 */
var fixtures = {
    'should be the answer to everything': {
        inp: 40 + 2,
        out: 42
    }
};
var should =   require("should");
var affix  =   require("affix")(fixtures);

describe( 'The answer', function () {
    it( affix.set( 'should be the answer to everything'),
        affix.bind( function () {
            var inp = this.fixture.inp;
            var out = this.fixture.out;
            inp.should.be.exactly( out );
        })
    );
});