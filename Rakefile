require 'echoe'

Echoe.new('sunlight', '0.1.0') do |p|
  p.author = "Ryan Stawarz and Robert Lasch"
  p.summary = "A client for connecting to Apache Solr Cell."
  p.url = "http://github.com/rlasch/sunlight"
  p.docs_host = ""
  p.ignore_pattern = ['tmp/*', 'script/*']
  p.runtime_dependencies = ["httpclient >=2.1.5.2", "nokogiri >=1.4.3.1"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

