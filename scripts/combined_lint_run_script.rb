# frozen_string_literal: true

# Get the base filename for this script
filename = File.basename(__FILE__)

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it! (#{filename})"
  return
end

scripts_directory = File.dirname(__FILE__)

system("ruby #{scripts_directory}/todo_warning_run_script.rb")

swiftlint_command = "ruby #{scripts_directory}/swiftlint_run_script.rb"
swiftlint_command += " #{ARGV[0]}" unless ARGV[0].nil?

system(swiftlint_command)
