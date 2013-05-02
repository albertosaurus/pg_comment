require "bundler/gem_tasks"

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

desc 'Run specs'
task 'spec' => ['db:drop', 'db:create', 'db:migrate', 'app:spec']
task :default => :spec
