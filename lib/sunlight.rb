$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'httpclient'
require 'nokogiri'

require 'sunlight/result'

module Sunlight
  VERSION = '0.0.1'
  
  class Ray
    
    attr_accessor :base_url
    
    
    def initialize(url = 'http://localhost:8983/solr/')
      @base_url = url
      @base_url = @base_url + '/' if (@base_url =~ /[^\/]+$/) 
    end
    
    
    def search(term, params = {})
      client = HTTPClient.new
      parameters = { :q => term, :f => "*,company_id" }.merge(params)
      response = client.post(url('select'), parameters)

      parse(response)
    end
    
    
    def update(path, id, params = {})
      response = nil
      File.open(path) do |file|
        body = { 'myfile' => file}
        query_string = {'literal.id' => id }
        query_string.merge!(params)
        puts "query string: #{query_string.inspect}"
        client = HTTPClient.new
        response = client.request('POST', url('update/extract'), query_string, body)
      end
   
    end
    
    
    def delete(id)
      response = nil
      body = "<delete><id>#{id}</id></delete>"
      client = HTTPClient.new
      params = {'Content-Type' => 'text/xml'}
      response = client.request('POST', url('update'), nil, body, params)
    end
    
    
    def commit()
      response = nil
      body = '<commit waitFlush="false" waitSearcher="false"/>'
      client = HTTPClient.new
      params = {'Content-Type' => 'text/xml'}
      response = client.request('POST', url('update'), nil, body, params)
    end
    
    
    private
    def url(str)
      puts "url #{@base_url}"
      @base_url + str
    end
  
    def parse(response)
      results = []
      puts "response #{response.body.content}"
      xml = Nokogiri::XML(response.body.content)
      xml.xpath('//doc').each() do |doc|
        r = Sunlight::Result.new()
        
        doc.traverse() do |element|
          name = element['name'] if element['name']
          if (name != 'arr')
            value = element.content
          end
          
          if value && name
            r.send(name + "=", value)
            name = nil
            value = nil
          end
        end
        
        # r.author = doc.xpath("//str[@name='author']").inner_text
        # r.content_type = doc.xpath("arr[@name='content_type']/str").inner_text
        # r.doc_id = doc.xpath("str[@name='id']").inner_text
        # r.title = doc.xpath("arr[@name='title']").inner_text
        results << r
      end

      results
    end
  end
  
end