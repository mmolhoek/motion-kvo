class Example
  include KVOHelper
  
  def initialize
    @label = UILabel.alloc.initWithFrame [[0,0],[320, 30]]
    @label.text = "Foo"
  end
  
  def label
    @label
  end
  
  def observe_label(&block)
    observe(@label, "text", &block)
  end
  
  def observe_old_value_on_label(&block)
    observe_old(@label, "text", &block)
  end
  
  def unobserve_all
    unobserve(@label, "text")
  end
  
end

describe "KVOHelper" do
  
  before do
    @example = Example.new
  end
  
  after do
    @example.unobserve_all
  end
  
  it "should be able to observe a key path" do
    observed = false
    @example.observe_label do |label|
      observed = true
      label.text.should == "Foo"
    end
    @example.label.text = "Foo"
    observed.should == true
  end
  
  it "should be able to observce a key path for the old value" do
    observed = false
    @example.observe_old_value_on_label do |label|
      observed = true
      label.text.should == "Bar"
    end
    @example.label.text = "Bar"
    observed.should == true
  end
  
end
