class Yt::Collections::Players
  private

  def players_params
    { max_results: 50, part: "player", id: @parent.id, max_width: 1920 }
  end
end

class Yt::Models::Player
  has_attribute :embed_height, type: Integer
  has_attribute :embed_width, type: Integer
end

class Yt::Models::Video
  delegate :embed_height, :embed_width, to: :player

  def shorts?
    embed_height == 3413 || embed_height > 1080
  end
end
