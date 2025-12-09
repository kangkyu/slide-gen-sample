class TrendingVideosTemplate < BaseTemplate
  def render
    @slide_id = new_page

    # slide sheet background color (white)
    presentation.batch_update({
      requests: [
        {
          update_page_properties: {
            object_id: @slide_id,
            page_properties: {
              page_background_fill: {
                solid_fill: {
                  color: {
                    rgb_color: {
                      red: 0,
                      green: 0,
                      blue: 0
                    }
                  }
                }
              }
            },
            fields: "pageBackgroundFill.solidFill.color.rgbColor"
          }
        }
      ]
    })

    # TODO
  end
end
