# frozen_string_literal: true

# Only run linting scripts locally, Danger will handle linting on CI
if ENV.key?('CI')
  puts "This script does not run on CI. Don't worry, Danger will handle it!"
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

command = "#{swiftlint_path} lint --no-cache"

# Allow passing in a file path for .swiftlint.yml, otherwise it looks in the project folder
command += " --config #{ARGV[0]}" unless ARGV[0].nil?

system(command)
