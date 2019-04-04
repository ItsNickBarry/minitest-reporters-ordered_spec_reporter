
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "minitest-reporters-ordered_spec_reporter"
  spec.version       = "1.1.1"
  spec.authors       = ["Nick Barry"]
  spec.email         = ["itsnickbarry@protonmail.ch"]

  spec.summary       = "Deterministically ordered and sorted test results."
  spec.description   = "Modified version of `Minitest::Reporters::SpecReporter` which prints test results in alphabetical order, grouped by test class."
  spec.homepage      = "https://github.com/itsnickbarry/minitest-reporters-ordered_spec_reporter"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "minitest-reporters", "~> 1.3.6"
end
