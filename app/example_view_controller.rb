class ExampleViewController < UIViewController
  include Dreimannzelt::KVO

  # View lifecycle

  def viewDidLoad
    view.backgroundColor = UIColor.grayColor
    create_main_label
    create_length_label
    create_text_field
    
    # UILabel.text is KVO compliant, that's an exception with UIKit
    observe(@main_label, "text") do |old_value, new_value|
      @length_label.text = "#{new_value.length}"
    end    
  end
  
  def viewWillDisapear(animated)
    unobserve(@main_label, "text")
  end
  
  # View setup
  
  def create_main_label
    @main_label = UILabel.alloc.initWithFrame [[0,0],[320,100]]
    @main_label.backgroundColor = UIColor.colorWithRed(0, green:0.7, blue:0, alpha:1)
    @main_label.textColor = UIColor.whiteColor
    @main_label.shadowColor = UIColor.blackColor
    @main_label.shadowOffset = [1,1]
    @main_label.font = UIFont.boldSystemFontOfSize 36
    @main_label.textAlignment = UITextAlignmentCenter
    @main_label.text = "RubyMotion"
    view.addSubview @main_label
    @main_label
  end
  
  def create_length_label
    @length_label = UILabel.alloc.initWithFrame [[170,110],[140,90]]
    @length_label.backgroundColor = UIColor.whiteColor
    @length_label.textColor = UIColor.blackColor
    @length_label.font = UIFont.boldSystemFontOfSize 36
    @length_label.textAlignment = UITextAlignmentCenter
    @length_label.text = "#{@main_label.text.length}"
    view.addSubview @length_label
    @length_label
  end
  
  def create_text_field
    @text_field = UITextField.alloc.initWithFrame [[10, 210], [300, 30]]
    @text_field.borderStyle = UITextBorderStyleRoundedRect
    @text_field.font = UIFont.boldSystemFontOfSize 21
    view.addSubview @text_field
    @text_field
  end
  
  # UITextFieldDelegate
  
  def textField(text_field, shouldChangeCharactersInRange:range, replacementString:string) 
    
    YES
  end

end