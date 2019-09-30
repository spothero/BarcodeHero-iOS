# frozen_string_literal: true

# Get the base filename for this script
filename = File.basename(__FILE__)

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it! (#{filename})"
  return
end

# Get the directory for this script
scripts_directory = File.dirname(__FILE__)

# The workspace directory should be one level up
workspace_directory = "#{scripts_directory}/.."

# If the workspace directory doesn't exist, exit
unless Dir.exist?(workspace_directory.to_s)
  warn "error: workspace directory '#{workspace_directory}' not found. (#{filename})"
  return
end

# Allow passing in a file path for .swiftlint.yml, otherwise it looks in the workspace root
swiftlint_yml_path = ARGV[0] || "#{workspace_directory}/.swiftlint.yml"

# Set the command
command = "mint run swiftlint swiftlint --config #{swiftlint_yml_path}"

# Call the command!
system(command)
