lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "model_log/version"

Gem::Specification.new do |spec|
  spec.name          = "model_log"
  spec.version       = ModelLog::VERSION::STRING
  spec.authors       = ["jk-sun"]
  spec.email         = ["jk-sun@qq.com"]

  spec.summary       = "Record all changes to the models into a log file for Rails"
  spec.description   = "It's designed to be used to record all changes to the models into a log file. You can also use it to record who made the changes"

  spec.required_ruby_version     = ">= 2.0.0"

  spec.homepage      = "https://github.com/JK-Sun/model_log"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 0"
  #spec.add_development_dependency "bundler", "~> 1.16"
  #spec.add_development_dependency "rake", "~> 10.0"
  #spec.add_development_dependency "rspec", "~> 3.0"
end
