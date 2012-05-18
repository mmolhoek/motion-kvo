$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  app.name = 'motion-kvo'
  app.identifier = "de.dreimannzelt.motion-kvo"
  
  # Libraries
  app.files.unshift(Dir.glob(File.join(app.project_dir, 'lib/**/*.rb')))
  
end
