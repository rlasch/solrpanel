

module Sunlight
  
  class Result
    attr_accessor :author, :content_type, :doc_id, :title
    
    def initialize
      @attrs = {}
    end
    
    def method_missing(id, value)
      str = id.id2name
      if str =~ /=$/
        @attrs[id] = value
      else
        if @attrs[id]
          return @attrs[id] 
        else
          return nil
        end
      end
    end
  end
  
end