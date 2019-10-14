# Updated for v6.0.9

# frozen_string_literal: true

# ============= #
#   Constants   #
# ============= #

SWIFTLINT_INLINE_MODE = ENV['INLINE_MODE'] != 'false'
RUBOCOP_INLINE_MODE = ENV['RUBOCOP_INLINE_MODE'] != 'false'
IS_LOCAL = ENV['IS_LOCAL'] == 'true'
IS_DEBUGGING = false

# ======================= #
#   Convenience Methods   #
# ======================= #

def cheer(message)
  message "👍 #{message}"
end

def debug_message(message)
  message "[Debug] #{message}" if IS_DEBUGGING && IS_LOCAL
end

def pr_title_tickets
  title_ticket_regex = /([A-Z0-9]{2,3}-[0-9]+)/
  github.pr_title.scan(title_ticket_regex).flatten || []
end

def pr_description_tickets
  description_ticket_regex = %r(spothero.atlassian.net\/browse\/([A-Z0-9]{2,3}-[0-9]+))
  github.pr_body.scan(description_ticket_regex).flatten || []
end

def validate_pull_request
  # TODO: Validate that the right branch is being merged, etc.
  # if branch_for_base == 'master' && branch_for_head != 'develop'
  #   fail ''
  # end

  # TODO: Update the title or description with appropriate tickets? Do we want to do this? If so, which is source of truth?

  # get tickets in the PR title
  title_tickets = pr_title_tickets

  # get tickets in the PR description
  description_tickets = pr_description_tickets

  # print some debugging info for validation
  debug_message "JIRA tickets in title: #{title_tickets.join(', ')}"
  debug_message "JIRA tickets in description: #{description_tickets.join(', ')}"

  # validate that either the PR title or description contain JIRA tickets
  if title_tickets.empty? && description_tickets.empty?
    warn 'There are no JIRA tickets in the PR title or description.'
    return
  end

  # validate that the same tickets are in the PR title and description
  if title_tickets.sort == description_tickets.sort
    cheer 'Pull request title and body JIRA tickets match!'
    return
  end

  # since we know the tickets in the title and description don't match,
  # we need to get the difference of both ticket arrays and evaluate them
  missing_title_tickets = (description_tickets - title_tickets).join(', ')
  missing_description_tickets = (title_tickets - description_tickets).join(', ')

  # if there are any tickets that are in the description but not in the title, warn
  warn "PR title is missing JIRA tickets: #{missing_title_tickets}" unless missing_title_tickets.empty?

  # if there are any tickets that are in the title but not in the description, warn
  warn "PR description is missing JIRA tickets: #{missing_description_tickets}" unless missing_description_tickets.empty?
end

# =========== #
#   Linting   #
# =========== #

# Validate that the Pull Request has a valid title and body
validate_pull_request

# Sources for all third-party tools can be found here:
# https://danger.systems/ruby/
# Scroll down and select the bubble that has the tool you're looking for

# Run the Danger-SwiftLint plugin and make inline comments with any warnings or errors
if defined?(swiftlint)
  swiftlint.lint_files(inline_mode: SWIFTLINT_INLINE_MODE)
end

# Run the Danger-Rubocop plugin and make inline comments with any warnings or errors
if defined?(rubocop)
  rubocop.lint(inline_comment: RUBOCOP_INLINE_MODE)
end

# Run the Danger-JUnit plugin and print test report summary to PR
if defined?(junit)
  # We need to check on whether or not we can access the generated junit report
  if ENV.key?('DANGER_JUNIT_PATH')
    junit.parse ENV['DANGER_JUNIT_PATH']
    junit.report

    if junit.passes.count == junit.tests.count
      message "#{junit.tests.count} tests ran. All passed! 🎉"
    else
      message "#{junit.tests.count} tests ran. #{junit.passes.count} passed, #{junit.failures.count} failed."
    end

    # Set some environment variables for Fastlane to work with after Danger is finished running
    ENV['DANGER_JUNIT_TESTS_COUNT'] = junit.tests.count.to_s
    ENV['DANGER_JUNIT_PASSES_COUNT'] = junit.passes.count.to_s
    ENV['DANGER_JUNIT_FAILURES_COUNT'] = junit.failures.count.to_s
    ENV['DANGER_JUNIT_ERRORS_COUNT'] = junit.errors.count.to_s
    ENV['DANGER_JUNIT_SKIPPED_COUNT'] = junit.skipped.count.to_s
  else
    warn 'The danger-junit plugin was found, but no DANGER_JUNIT_PATH was set.'
  end
end

# We need a pat on the back sometimes!
message '👋 👋 Great job!' if status_report[:errors].empty? && status_report[:warnings].empty?
