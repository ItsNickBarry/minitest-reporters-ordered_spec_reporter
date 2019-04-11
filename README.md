# Minitest::Reporters::OrderedSpecReporter

Modified version of `Minitest::Reporters::SpecReporter` which prints test results in alphabetical order, grouped by test suite.

This gem makes use of the `minitest-reporters` library.  It modifies the test reporting order, but not Minitest's randomized test execution order.

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
| `:indentation` | number of indentations to apply to top level test suite reports | `0` |
| `:spaces` | number of spaces per indentation level | `2` |
| `:justification` | width of the test description column | `65` (aligns with default `SpecReporter`)|
| `:truncate` | whether to remove the `test_####_` prefix from each test name | `false` |
| `:loose` | whether to add a blank line after each group of tests | `false` |
| `:color` | options hash describing color options (see below) or `false` to disable colors | `{ suite: :yellow, test: :cyan }` |

#### Color Options

All color options from the [ANSI](https://github.com/rubyworks/ansi) library are accepted.

| option | description | default |
|-|-|-|
| `:suite` | color applied to test suite name | `:yellow` |
| `:test` | color applied to test name | `:cyan` |
| `:match` | hash of `Regexp` to color | `{}` |

Colors provided through the `:match` options take precedence over the `:suite` and `:test` colors.  If there are multiple matches, the first is applied.
