class DataFashion
  attr_reader :activity

  def initialize(activity)
    @activity = activity
  end

  def fetch_data
    category_id = 23
    payload = []
    videos = Yt::Collections::Videos.new
    videos.where(chart: "mostPopular", region_code: "US", video_category_id: category_id, part: "snippet,statistics,contentDetails,player").first(5).each do |video|
      payload.push({ category: category_id, video_id: video.id, is_shorts_video: video.shorts?, title: video.title })
    end
    { videos: payload }
  rescue Yt::Errors::RequestError
    Rails.logger.info "Category #{category_id} returns an error on chart=mostPopular"
    raise
  end
end
