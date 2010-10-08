require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/
describe "SolrPanel::Result" do

  before(:each) do
    @result = SolrPanel::Result.new()
  end
  
  it "should set a value" do
    @result.my_id = "my_id"
    puts @result.inspect
    @result.my_id.should == "my_id"
  end

end

