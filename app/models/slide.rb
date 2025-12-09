class Slide < ApplicationRecord
  belongs_to :user

  enum :status, %i[pending successful failed]

  validates :presentation_id, format: { with: /\A[a-zA-Z0-9_-]{44}\Z/,
    message: "requires 44 letters" }, allow_nil: true

  after_commit :process, on: :create

  def process
    ActivityJob.perform_later self
  end

  def run
    fetch_youtube
    generate_slide
    successful! if pending?

    broadcast_status_update
  rescue Gslide::UnauthorizedError
    begin
      user.token_refreshed
      sleep 0.1  # Give the db time to save
      @editor = Gslide::Editor.new(user.access_token)
      @presentation = Gslide::Presentation.new(presentation_id, auth: @editor)
      retry
    rescue => e
      debugger
      failed!
      broadcast_status_update
    end
  rescue => e
    debugger
    failed!
    broadcast_status_update
  end

  def presentation_url
    presentation.link_url if presentation
  end

  private

  def fetch_youtube
    self.data = data_fashion.fetch_data
  end

  def generate_slide
    template = TrendingVideosTemplate.new(presentation, data)
    template.render
  end

  def data_fashion
    @data_fashion ||= DataFashion.new self
  end

  def presentation
    @presentation ||= Gslide::Presentation.new(presentation_id, auth: editor) if presentation_id
  end

  def editor
    @editor ||= Gslide::Editor.new(user.access_token)
  end

  def broadcast_status_update
    broadcast_replace_to "slide_#{id}",
      target: "status_indicator_#{id}",
      partial: "slides/status_indicator",
      locals: { activity: self }

    broadcast_replace_to "slide_#{id}",
      target: "content_status_#{id}",
      partial: "slides/content_status",
      locals: { activity: self }
  end
end
