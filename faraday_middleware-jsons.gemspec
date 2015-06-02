# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "faraday_middleware-jsons"
  spec.version       = File.read(File.expand_path("../VERSION", __FILE__)).chomp
  spec.authors       = ["okitan"]
  spec.email         = ["okitakunio@gmail.com"]

  spec.summary       = "Faraday Middleware coping with variety of json (patch, hal, etc)"
  spec.description   = "Faraday Middleware coping with variety of json (patch, hal, etc)"
  spec.homepage      = "https://github.com/okitan/faraday_middleware-jsons"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 0.8"
  spec.add_dependency "multi_json"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  # test
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
