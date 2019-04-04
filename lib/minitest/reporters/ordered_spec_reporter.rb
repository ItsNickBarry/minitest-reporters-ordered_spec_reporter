require 'minitest/reporters'

module Minitest
  module Reporters
    # inherit from BaseReporter, not SpecReporter, in case the latter is updated
    class OrderedSpecReporter < BaseReporter
      include ANSI::Code
      include RelativePosition

      def initialize options = {}
        super(options)

        @options = {
          indentation: 0,
          spaces: 2,
          truncate: false,
          loose: false,
        }.merge(options)
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

        puts unless @options[:loose] # already printed by last suite if true
        puts('Finished in %.5fs' % total_time)
        print('%d tests, %d assertions, ' % [count, assertions])
        color = failures.zero? && errors.zero? ? :green : :red
        print(send(color) { '%d failures, %d errors, ' } % [failures, errors])
        print(yellow { '%d skips' } % skips)
        puts
      end

      protected

      def print_suite(name, branch, indentation = @options[:indentation])
        branch = branch.sort.to_h

        total_indentation = ' ' * indentation * @options[:spaces]

        puts total_indentation + name unless name.nil?

        if branch[:tests]
          branch[:tests].each do |test|
            print total_indentation
            print_test(test)
          end
          puts if @options[:loose]
        end

        branch.each do |k, v|
          print_suite k, v, indentation + 1 unless k == :tests
        end
      end

      def print_test(test)
        record_print_status(test)
        record_print_failures_if_any(test)
      end

      def record_print_status(test)
        test_name = test.name.gsub(/^test_: /, 'test:')
        test_name = test_name.gsub(/^test_\d*_/, '') if @options[:truncate]
        print pad_test(test_name)
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
    end
  end
end
