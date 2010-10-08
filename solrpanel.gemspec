# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{solrpanel}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Stawarz and Robert Lasch"]
  s.date = %q{2010-10-07}
  s.description = %q{A client for connecting to Apache Solr Cell.}
  s.email = %q{}
  s.extra_rdoc_files = ["README.rdoc", "lib/solrpanel.rb", "lib/solrpanel/result.rb", "lib/solrpanel/solrpanel.rb", "tasks/rspec.rake"]
  s.files = ["History.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/solrpanel.rb", "lib/solrpanel/result.rb", "lib/solrpanel/solrpanel.rb", "solrpanel.gemspec", "spec/ray_spec.rb", "spec/result_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake", "Manifest"]
  s.homepage = %q{http://github.com/rlasch/solrpanel}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Solrpanel", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{solrpanel}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A client for connecting to Apache Solr Cell.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httpclient>, [">= 2.1.5.2"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.3.1"])
    else
      s.add_dependency(%q<httpclient>, [">= 2.1.5.2"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.3.1"])
    end
  else
    s.add_dependency(%q<httpclient>, [">= 2.1.5.2"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.3.1"])
  end
end
