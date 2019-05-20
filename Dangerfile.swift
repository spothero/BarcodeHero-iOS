import Danger

let danger = Danger()

// MARK: Constants

// let isLocal = true// = ENV['IS_LOCAL'] == 'true'
// let isDebugging = false

// MARK: Convenience Methods

// func cheer(message: String) {
//     message("👍 \(message)")
// }

// func debugMessage(message: String) {
//     guard isLocal && isDebugging else {
//         return
//     }
  
//     message("[Debug] \(message)")
// }

// func validatePullRequest() {

// }

// def pr_title_tickets
//   title_ticket_regex = /([A-Z0-9]{2,3}-[0-9]+)/
//   github.pr_title.scan(title_ticket_regex).flatten || []
// end

// def pr_description_tickets
//   description_ticket_regex = %r(spothero.atlassian.net\/browse\/([A-Z0-9]{2,3}-[0-9]+))
//   github.pr_body.scan(description_ticket_regex).flatten || []
// end

// def validate_pull_request
//   # TODO: Validate that the right branch is being merged, etc.
//   # if branch_for_base == 'master' && branch_for_head != 'develop'
//   #   fail ''
//   # end

//   # TODO: Update the title or description with appropriate tickets? Do we want to do this? If so, which is source of truth?

//   # get tickets in the PR title
//   title_tickets = pr_title_tickets

//   # get tickets in the PR description
//   description_tickets = pr_description_tickets

//   # print some debugging info for validation
//   debug_message "JIRA tickets in title: #{title_tickets.join(', ')}"
//   debug_message "JIRA tickets in description: #{description_tickets.join(', ')}"

//   # validate that either the PR title or description contain JIRA tickets
//   if title_tickets.empty? && description_tickets.empty?
//     warn 'There are no JIRA tickets in the PR title or description.'
//     return
//   end

//   # validate that the same tickets are in the PR title and description
//   if title_tickets.sort == description_tickets.sort
//     cheer 'Pull request title and body JIRA tickets match!'
//     return
//   end

//   # since we know the tickets in the title and description don't match,
//   # we need to get the difference of both ticket arrays and evaluate them
//   missing_title_tickets = (description_tickets - title_tickets).join(', ')
//   missing_description_tickets = (title_tickets - description_tickets).join(', ')

//   # if there are any tickets that are in the description but not in the title, warn
//   warn "PR title is missing JIRA tickets: #{missing_title_tickets}" unless missing_title_tickets.empty?

//   # if there are any tickets that are in the title but not in the description, warn
//   warn "PR description is missing JIRA tickets: #{missing_description_tickets}" unless missing_description_tickets.empty?
// end

// MARK: Linting

// Validate that the Pull Request has a valid title and body
// validatePullRequest()

// Run the SwiftLint and make inline comments with any warnings or errors
SwiftLint.lint(inline: true)

// Run the Danger-Rubocop plugin and make inline comments with any warnings or errors
// rubocop.lint inline_comment: true

// We need a pat on the back sometimes!
// if danger.statusReport["errors"].isEmpty && danger.statusReport["warnings"].isEmpty {
    message("👋 👋 Great job!")
// }
