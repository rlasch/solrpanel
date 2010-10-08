# Copyright (c) 2010 Robert Lasch and Ryan Stawarz
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 


# SolrPanel is a very simple, lightweight library for accessing Apache Solr.  
module SolrPanel
  VERSION = '0.0.1'
  
  # Main client for the SolrPanel library.
  class Ray
    attr_accessor :base_url
    attr_accessor :default_query_parameters
    
    
    # , :f => "*,company_id" 
    def initialize(url = 'http://localhost:8983/solr/', params = {})
      @base_url = url
      @base_url = @base_url + '/' if (@base_url =~ /[^\/]+$/) 
      @default_query_parameters = params
    end
    
    
    # Search for the term found in the 
    def search(term, params = {})
      client = HTTPClient.new
      parameters = { :q => term }.merge(params)
      puts @default_query_parameters.inspect
      parameters = parameters.merge(@default_query_parameters)
      response = client.post(url('select'), parameters)

      parse(response)
    end
    
    
    def update(path, id, params = {})
      response = nil
      File.open(path) do |file|
        body = { 'myfile' => file}
        update_params = {'literal.id' => id }
        update_params.merge!(params)
        client = HTTPClient.new
        response = client.request('POST', url('update/extract'), update_params, body)
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
      @base_url + str
    end
  
    def parse(response)
      results = []
      xml = Nokogiri::XML(response.body.content)
      xml.xpath('//doc').each() do |doc|
        r = SolrPanel::Result.new()
        
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

        results << r
      end

      results
    end
  end
  
end