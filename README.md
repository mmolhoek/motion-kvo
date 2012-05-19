# Key-Value-Observing for RubyMotion

A domain specific language (DSL) for easy use of key-value-observing (KVO) in RubyMotion projects. 

If you'd like to learn more about the KVO mechanism on iOS and Mac, take a look at the [Key-Value Observing Programming Guide](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) by Apple.
	

## Getting started

Add motion-kvo as a git submodule of your RubyMotion project:

    git clone https://github.com/dreimannzelt/motion-kvo.git vendor/motion-kvo

Add the motion-kvo lib path to your project 'Rakefile'

```ruby
Motion::Project::App.setup do |app|
  app.name = 'MyApp'
  app.files.unshift(Dir.glob(File.join(app.project_dir, 'vendor/motion-kvo/lib/**/*.rb')))
end
```
Now you can start to add the helper methods to every class you like:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	...
end
```

## Register observers

To observe a key path of a target you do:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	def viewDidLoad
		@label = create_ui_label()
		
		observe(@label, "text") do |old_value, new_value|
			puts "Changed #{old_value} to #{new_value}"
		end
	end
	
end
```

It's possible to add more than one block to the same key path:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	def viewDidLoad
		@label = create_ui_label()
		
		observe(@label, "text") do |old_value, new_value|
			puts "Hello from viewDidLoad!"
		end		
	end
	
	def viewDidAppear(animated)
		observe(@label, "text") do |old_value, new_value|
			puts "Hello from viewDidAppear!"
		end
	end
	
end
```

You can also observe collections (WORK IN PROGRESS):

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	attr_accessor :items
	
	def viewDidLoad
		@table_view = create_ui_table_view()
		@items = [ ]
		
		observe(self, "items") do |old_value, new_value, indexes|
			@table.reloadData
		end
	end
	
end
```

## Unregister observers

You are responsible to unregister observers properly. You can unregister one observer:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	...
	
	def viewWillDisappear(animated)
		unobserve(@label, "text")
	end
	
end
```

or all at once:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVO
	
	...
	
	def viewWillDisappear(animated)
		unobserve_all
	end
	
end
```

## License

motion-kvo is released under the MIT license:

http://www.opensource.org/licenses/MIT
