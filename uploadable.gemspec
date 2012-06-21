require File.expand_path('../lib/data_sanity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Garima"]
  gem.email = ["igarimasingh@gmail.com"]
  gem.description = %q{Upload your csv to activerecord model}
  gem.summary = %q{This gem gives you flexibility to upload the csv to you model. It also comes packed with some customizations}
  gem.homepage = "https://github.com/singhgarima/data_sanity"

  gem.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {spec}/*`.split("\n")
  gem.name = "uploadable"
  gem.require_paths = ["lib"]
  gem.version = Uploadable::VERSION
  gem.license = 'MIT'

  gem.add_dependency 'fastercsv'
end

