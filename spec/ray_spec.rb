require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "Sunlight::Ray" do

  before(:each) do
    @sunlight = Sunlight::Ray.new
    results = @sunlight.search 'comma'  
    results.each() do |r|
      @sunlight.delete(r.id)
    end
    @sunlight.commit()
  end
  
  after(:each) do
    @sunlight.delete("test1")
    @sunlight.delete("test2")
    @sunlight.commit()
  end
  
  
  it "should update a document in the index" do
    results = @sunlight.update 'spec/test1.pdf', 'test1'
    results.should_not be_nil

    @sunlight.commit
  end  
  

  it "should find documents when searching" do
    results = @sunlight.update 'spec/test1.pdf', 'test1'
    results.should_not be_nil

    @sunlight.commit

    results = @sunlight.search 'comma'  
    results.should_not be_nil
    results.class.should be_eql(Array)
    results.length.should be_eql(1)

    results[0].title.should be_eql("STYLE GUIDE FOR WRITING")
    results[0].content_type.should be_eql("application/pdf")
    results[0].id.should be_eql("test1")
  end  


  it "should not find documents when searching an empty index" do
    results = @sunlight.search 'comma'  
    results.should_not be_nil
    results.class.should be_eql(Array)
    results.length.should be_eql(0)
  end  
  
end

