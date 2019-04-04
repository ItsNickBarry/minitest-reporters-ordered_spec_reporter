require 'minitest/reporters'

module Minitest
  module Reporters
    # inherit from BaseReporter, not SpecReporter, in case the latter is updated
    class OrderedSpecReporter < BaseReporter
      include ANSI::Code
      include RelativePosition

      @@default_options = {
        indentation: 0,
        spaces: 2,
        justification: TEST_SIZE + TEST_PADDING, # match output of SpecReporter
        truncate: false,
        loose: false,
      }

      def initialize options = {}
        super(@@default_options.merge(options))
      end

      def start
        super
        puts('Started with run options %s' % options[:args])
        puts
      end

      def report
        super

        tree = {}

        self.tests.each do |test|
          branch = tree

          test.klass.split('::').each do |klass|
            branch = (branch[klass] ||= {})
          end

          (branch[:tests] ||= []) << test
        end

        tree.sort.to_h.each { |k, v| print_suite(k, v) }

        puts unless options[:loose] # already printed by last suite if true
        puts('Finished in %.5fs' % total_time)
        print('%d tests, %d assertions, ' % [count, assertions])
        color = failures.zero? && errors.zero? ? :green : :red
        print(send(color) { '%d failures, %d errors, ' } % [failures, errors])
        print(yellow { '%d skips' } % skips)
        puts
      end

      protected

      def print_suite(name, branch, indentation = options[:indentation])
        puts pad_string(name, indentation) unless name.nil?

        indentation += 1

        if branch[:tests]
          branch[:tests].each do |test|
            print_test(test, indentation)
          end
          puts if options[:loose]
        end

        branch.sort.to_h.each do |k, v|
          print_suite k, v, indentation unless k == :tests
        end
      end

      def print_test(test, indentation)
        record_print_status(test, indentation)
        record_print_failures_if_any(test)
      end

      def record_print_status(test, indentation)
        test_name = test.name.gsub(/^test_: /, 'test:')
        test_name = test_name.gsub(/^test_\d*_/, '') if options[:truncate]
        print pad_string(test_name, indentation)
        print_colored_status(test)
        print(" (%.2fs)" % test.time) unless test.time.nil?
        puts
      end

      def record_print_failures_if_any(test)
        if !test.skipped? && test.failure
          print_info(test.failure, test.error?)
          puts
        end
      end

      def pad_string(str, indentation)
        (' ' * indentation * options[:spaces] + str).ljust(options[:justification])
      end
    end
  end
end
