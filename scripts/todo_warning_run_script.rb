# frozen_string_literal: true

# Get the base filename for this script
filename = File.basename(__FILE__)

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it! (#{filename})"
  return
end

tags = 'TODO:|FIXME:|WARN:|WARNING:'
path = ENV['SRCROOT'] || '.'

puts "searching #{path} for #{tags}"

command = "find #{path} -name \"*.swift\" -print0"
command += " | xargs -0 egrep --with-filename --line-number --only-matching \"(#{tags}).*\\$\""
command += " | perl -p -e \"s/(#{tags})/ warning: \\$1/\""

puts command

system(command)
