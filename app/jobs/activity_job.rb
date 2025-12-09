class ActivityJob < ApplicationJob
  queue_as :default
  # retry_on Yt::Errors::Unauthorized, wait: 21.seconds, attempts: 2

  def perform(activity)
    activity.run
  end
end
