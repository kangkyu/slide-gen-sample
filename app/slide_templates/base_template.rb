class BaseTemplate
  attr_accessor :presentation, :data

  def initialize(presentation, data)
    @data = data
    @presentation = presentation
  end

  def render
    # override in the subclass
  end

  private

  def new_page
    new_layout
    slide_ids = presentation.get_slide_ids
    slide_ids.last
  end

  def new_layout
    presentation.batch_update({
      requests: [
        {
          create_slide: {
            slide_layout_reference: { predefined_layout: "BLANK" }
          }
        }
      ]
    })
  end

  def generate_id(length)
    # The object ID (-NxhA9ykPiQ1) should start with a word character [a-zA-Z0-9_] and then
    # followed by any number of the following characters [a-zA-Z0-9_-:].
    possible_chars = ("0".."9").to_a + ("a".."z").to_a + ("A".."Z").to_a + ["_"]
    possible_chars.sample(length).join
  end

  # left and right margin
  def margin_x
    32  # 32 + 896 + 32 = 960 points / 13.33 inches wide
  end

  # top margin
  def margin_y
    36
  end
end
