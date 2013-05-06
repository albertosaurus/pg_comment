require 'bundler/gem_tasks'

APP_RAKEFILE = File.expand_path('../spec/dummy/Rakefile', __FILE__)
load 'rails/tasks/engine.rake'

desc 'Run specs'
task 'spec' => ['db:drop', 'db:create', 'db:migrate', 'app:spec']
task :default => :spec

def gemspec
  @gem_spec ||= eval( open( `ls *.gemspec`.strip ){|file| file.read } )
end

def gem_version
  gemspec.version
end

def gem_version_tag
  "v#{gem_version}"
end

def gem_name
  gemspec.name
end

def gem_file_name
  "#{gem_name}-#{gem_version}.gem"
end

namespace :git do
  desc "Create git version tag #{gem_version}"
  task :tag do
    sh "git tag -a #{gem_version_tag} -m \"Version #{gem_version}\""
  end

  desc 'Push git tag to GitHub'
  task :push_tags do
    sh 'git push --tags'
  end
end
