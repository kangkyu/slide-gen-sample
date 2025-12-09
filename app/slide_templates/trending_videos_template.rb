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
    start_y = margin_y + 32

    text(start_y, data["videos"].to_s)
  end

  def text(start_y, text = "-", text_color = { red: 1, green: 1, blue: 1 })
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 15, unit: "PT" },
                width: { magnitude: content_x, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: margin_x - 2,
                translate_y: start_y,
                unit: "PT"
              }
            },
            shape_type: "TEXT_BOX"
          }
        },
        {
          insert_text: {
            object_id: generated_id,
            text: text,
            insertion_index: 0
          }
        },
        {
          update_text_style: {
            object_id: generated_id,
            style: {
              weighted_font_family: { font_family: "Raleway", weight: 600 },
              font_size: { magnitude: 8, unit: "PT" },
              foreground_color: {
                opaque_color: {
                  rgb_color: text_color
                }
              }
            },
            fields: "*"
          }
        }
      ]
    })
  end
end
