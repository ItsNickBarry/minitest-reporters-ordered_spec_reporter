# Minitest::Reporters::OrderedSpecReporter

Modified version of `Minitest::Reporters::SpecReporter` which prints test results in alphabetical order, grouped by test class.

This gem makes use of the 'minitest-reporters' library.  It modifies the test reporting order, but not Minitest's randomized test execution order.

## Installation

Add to an application's Gemfile as a dependency:

```ruby
gem 'minitest-reporters-ordered_spec_reporter'
```

Install:

```
bundle install
```

## Usage

Load the reporter:

```ruby
Minitest::Reporters.use! Minitest::Reporters::OrderedSpecReporter.new
```

For more information, see the [minitest-reporters documentation](https://github.com/kern/minitest-reporters).

### Options

The constructor accepts the following options:

| option | description | default |
|-|-|-|
| `:indentation` | number of indentations to apply to top level test class reports | `0` |
| `:spaces` | number of spaces per indentation level | `2` |
| `:truncate` | whether to remove the `test_####_` prefix from each test name | `true` |
