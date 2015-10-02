# Affix - Binding made more fluent

## Intro

A simple utility module to make binding more [fluent](https://www.google.co.uk/webhp?sourceid=chrome-instant&ion=1&espv=2&es_th=1&ie=UTF-8#es_th=1&q=fluent%20api), with some helpers for testing.

## Why?

(1) It can be easy to miss a bind call:

    function () {
        .... lots of code ....
    }.bind(context);

(2) Given the typical fluent testing framework:
    
    it(<descriptionStr>, <workFn>);

It can be useful to bind your `workFn` functions to your fixture data. Affix lets you use one fixture object using the `descriptionStr` as a _cursor_ 

Thus, _without doing anything drastic_ to the test structure, you can wire fixtures at _test definition time_. It was originally used for keyhole refactoring of some large test files, thus it is super-simple and non-invasive.

## Usage

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
