# Key-Value-Observing for RubyMotion

A DSL for easy use of KVO in RubyMotion projects.

## Getting started

Add motion-kvo as a git submodule of your RubyMotion project:

    git clone https://github.com/dreimannzelt/motion-kvo.git vendor/motion-kvo

Add the motion-kvo lib path to your project 'Rakefile'

```ruby
Motion::Project::App.setup do |app|
  app.name = 'myapp'
  app.files.unshift(Dir.glob(File.join(app.project_dir, 'vendor/motion-kvo/lib/**/*.rb')))
end
```
Now you can start to add the helper methods from the module KVOHelper to every class you like:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVOHelper
	
end
```

To observe a a key path on an object:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVOHelper
	
	def viewDidLoad
		@label = create_ui_label
		
		observe(@label, "text") do |label, old_value, new_value|
		end
	end
	
end
```

It's important to unregister your observer if it or the target (e.g a label) will disappear. You can do it for one observer:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVOHelper
	
	...
	
	def viewWillDisappear(animated)
		unobserve(@label, "text")
	end
	
end
```

Or for all:

```ruby
class ExampleViewController < UIViewController
	include Dreimannzelt::KVOHelper
	
	...
	
	def viewWillDisappear(animated)
		remove_all_observers
	end
	
end
```

