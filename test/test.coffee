fixtures = {test: 1}
affix = require("../src/main") fixtures
hook = -> console.log "Fixture is", @fixture

affix.set "test"
hookSetThenBound = affix.bind hook
hookSetThenBound()

hookSetAndBound = affix.setBind "test", hook
hookSetAndBound()