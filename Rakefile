require 'echoe'

Echoe.new('solrpanel', '0.1.1') do |p|
  p.author = "Ryan Stawarz and Robert Lasch"
  p.summary = "A client for connecting to Apache Solr Cell."
  p.url = "http://github.com/rlasch/solrpanel"
  p.docs_host = ""
  p.ignore_pattern = ['tmp/*', 'script/*', 'spec/*']
  p.runtime_dependencies = ["httpclient >=2.1.5.2", "nokogiri >=1.4.3.1"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

