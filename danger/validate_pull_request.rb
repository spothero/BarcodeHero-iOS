def validate_pull_request
  # create regex objects for matching JIRA ticket keys
  title_ticket_regex = /([A-Z]{2,3}-[0-9]+)/
  description_ticket_regex = /spothero.atlassian.net\/browse\/([A-Z]{2,3}-[0-9]+)/

  # get tickets in the PR title
  title_tickets = github.pr_title.scan(title_ticket_regex).flatten || []

  # get tickets in the PR description
  description_tickets = github.pr_body.scan(description_ticket_regex).flatten || []

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
