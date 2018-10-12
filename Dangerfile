require_relative 'danger/cheer.rb'
require_relative 'danger/debug_message.rb'
require_relative 'danger/validate_pull_request.rb'

# ============== #
#   PR Linting   #
# ============== #

# TODO: Validate that the right branch is being merged, etc.
# if branch_for_base == 'master' && branch_for_head != 'develop'
#     fail ''
# end

# TODO: Update the title or description with appropriate tickets? Do we want to do this? If so, which is source of truth?

validate_pull_request

# ================ #
#   Code Linting   #
# ================ #

# Run the Danger-SwiftLint plugin and make inline comments with any warnings or errors
swiftlint.lint_files inline_mode: true

# Run the Danger-Rubocop plugin and make inline comments with any warnings or errors
rubocop.lint inline_comment: true

# ==================== #
#   Congratulations!   #
# ==================== #

# We need a pat on the back sometimes!
message '👋 👋 Great job!' if status_report[:errors].empty? && status_report[:warnings].empty?
