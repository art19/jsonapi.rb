require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yaml'
require 'yardstick'

desc 'Build the package and publish it to rubygems.pkg.github.com'
task publish: :build do
  # Requires local setup of personal access token, see:
  # 1. https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-rubygems-registry#authenticating-with-a-personal-access-token
  system("gem push --key github --host https://rubygems.pkg.github.com/art19 " \
         "pkg/jsonapi.rb-#{JSONAPI::VERSION}.gem")
end

# rubocop:disable Rails/RakeEnvironment
desc('Documentation stats and measurements')
task('qa:docs') do
  yaml = YAML.load_file(File.expand_path('../.yardstick.yml', __FILE__))
  config = Yardstick::Config.coerce(yaml)
  measure = Yardstick.measure(config)
  measure.puts
  coverage = Yardstick.round_percentage(measure.coverage * 100)
  exit(1) if coverage < config.threshold
end
# rubocop:enable Rails/RakeEnvironment

desc('Codestyle check and linter')
RuboCop::RakeTask.new('qa:code') do |task|
  task.fail_on_error = true
  task.patterns = [
    'lib/**/*.rb',
    'spec/**/*.rb'
  ]
end

desc('Run CI QA tasks')
if ENV['RAILS_VERSION'].to_s.include?('4')
  task(qa: ['qa:docs'])
else
  task(qa: ['qa:docs', 'qa:code'])
end

RSpec::Core::RakeTask.new(:spec)
task(default: %w[qa spec])
