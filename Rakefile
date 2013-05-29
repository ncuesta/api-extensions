require 'bundler/gem_tasks'
require 'cucumber/rake/task'


Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

Cucumber::Rake::Task.new(:"features:html", 'Run Cucumber features and produce HTML output') do |t|
  t.profile = 'html_report'
end

task default: :features