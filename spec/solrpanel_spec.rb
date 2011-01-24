require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "SolrPanel::Client" do

  before(:each) do
    @solrpanel = SolrPanel::Client.new
    results = @solrpanel.search 'test'  
    results.each() do |r|
      @solrpanel.delete(r.id)
    end
    @solrpanel.commit()
  end
  
  after(:each) do
    @solrpanel.delete("test1")
    @solrpanel.delete("test2")
    @solrpanel.commit()
  end
  
  
  it "should update a document in the index" do    
    results = @solrpanel.update 'spec/test1.pdf', 'test1'
    results.should_not be_nil

    @solrpanel.commit
  end  
  

  it "should find documents when searching" do
    results = @solrpanel.update 'spec/test1.pdf', 'test1'
    results.should_not be_nil

    @solrpanel.commit

    results = @solrpanel.search 'test'  
    results.should_not be_nil
    results.class.should be_eql(Array)
    puts "Results: #{results.length}"
    results.length.should be_eql(1)

    puts "Title: #{results[0].title}"
    results[0].content_type.should be_eql("application/pdf")
    results[0].id.should be_eql("test1")
  end  


  it "should not find documents when searching an empty index" do
    results = @solrpanel.search 'another'  
    results.should_not be_nil
    results.class.should be_eql(Array)
    results.length.should be_eql(0)
  end  
  
end

