module SlackNotifier
  USER_SLACK = Slack::Notifier.new ENV['USER_SLACK_WEBHOOK']
  REVIEW_SLACK = Slack::Notifier.new ENV['REVIEW_SLACK_WEBHOOK']
end
