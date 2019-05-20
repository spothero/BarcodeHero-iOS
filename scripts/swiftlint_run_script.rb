# frozen_string_literal: true

# Get the base filename for this script
filename = File.basename(__FILE__)

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it! (#{filename})"
  return
end

pods_path = ENV['PODS_ROOT'] || 'Pods'

# These are our default swiftlint run paths
pod_swiftlint_path = "#{pods_path}/SwiftLint/swiftlint"
spm_swiftlint_path = 'swift run swiftlint'

# Check if we installed swiftlint with Cocoapods
should_use_pod_swiftlint = File.file?(pod_swiftlint_path)

# Set the path based on whether or not we are using Cocoapods or SPM
swiftlint_path = if should_use_pod_swiftlint
                   pod_swiftlint_path
                 else
                   spm_swiftlint_path
                 end

# Get the directory for this script
scripts_directory = File.dirname(__FILE__)

# The workspace directory should be one level up
workspace_directory = "#{scripts_directory}/../"

# If the workspace directory doesn't exist, exit
unless Dir.exist?(workspace_directory.to_s)
  warn "error: workspace directory '#{workspace_directory}' not found. (#{filename})"
  return
end

# Allow passing in a file path for .swiftlint.yml, otherwise it looks in the workspace root
swiftlint_yml_path = ARGV[0] || "#{workspace_directory}/.swiftlint.yml"

# Set the command
command = "#{swiftlint_path} lint --no-cache --config #{swiftlint_yml_path}"

# Call the command!
system(command)
