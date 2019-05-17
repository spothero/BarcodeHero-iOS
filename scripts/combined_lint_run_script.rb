# frozen_string_literal: true

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it!"
  return
end

scripts_directory = File.dirname(__FILE__)

system("ruby #{scripts_directory}/todo_warning_run_script.rb")
system("ruby #{scripts_directory}/swiftlint_run_script.rb")
