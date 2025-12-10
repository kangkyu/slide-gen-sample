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
                    rgb_color: black_color
                  }
                }
              }
            },
            fields: "pageBackgroundFill.solidFill.color.rgbColor"
          }
        }
      ]
    })

    start_y = margin_y
    hexagon("1", 394.92, start_y)
    title_text(data["videos"][0]["title"], 490.32, start_y + 16)

    start_y += 68.40
    hexagon("2", 463.32, start_y)
    title_text(data["videos"][1]["title"], 267.12, start_y + 16)


    start_y += 68.40
    hexagon("3", 394.92, start_y)
    title_text(data["videos"][2]["title"], 490.32, start_y + 16)


    start_y += 68.40
    hexagon("4", 463.32, start_y)
    title_text(data["videos"][3]["title"], 267.12, start_y + 16)


    start_y += 68.40
    hexagon("5", 394.92, start_y)
    title_text(data["videos"][4]["title"], 490.32, start_y + 16)

    # TODO: data["videos"]
    # [{"category" => 23, "video_id" => "2Di_sNWKgAw", "is_shorts_video" => true, "title" => "He Endured to Protect Them.#TheGreatDebaters #DenzelWashington #DebateTeam"}, {"category" => 23, "video_id" => "JiWFeItif8A", "is_shorts_video" => true, "title" => "How did people survive before online doctors?#shorts #viral #trending #funny #max"}, {"category" => 23, "video_id" => "OE8HyWtZGbI", "is_shorts_video" => true, "title" => "I feel bad for her on here tbh #series #daughter #viral #explore #shorts #feed #family #drama #movie"}, {"category" => 23, "video_id" => "JM4DEI0wUwA", "is_shorts_video" => true, "title" => "🍎📚 Abbott Elementary (S4 Ep.2) — “We’ve Got a Situation!”｜Teachers vs. Classroom Chaos😂🧼#shorts"}, {"category" => 23, "video_id" => "Yjys3qzzjc4", "is_shorts_video" => true, "title" => "Marge's surgery didn't go as planned #simpsons #shorts"}]

    generated_id = generate_id(12)
    presentation.batch_update({
      requests: [
        {

          create_line: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 405.36, unit: "PT" },
                width: { magnitude: 4, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: 214.56,
                translate_y: 0,
                unit: "PT"
              }
            },
            category: "STRAIGHT"
          }
        },
        {
          update_line_properties: {
            object_id: generated_id,
            line_properties: {
              line_fill: {
                solid_fill: {
                  color: {
                    rgb_color: white_color
                  },
                  alpha: 1.0
                }
              },
              weight: { magnitude: 3, unit: "PT" },
              dash_style: "SOLID"
            },
            fields: "lineFill.solidFill.color,weight,dashStyle"
          }
        }
      ]
    })
    start_x = margin_x
    side_text("COMEDY\nTRENDING\nVIDEOS", start_x, 136.28)
  end

  def white_color
    {
      red: 1,
      green: 1,
      blue: 1
    }
  end

  def black_color
    {
      red: 0,
      green: 0,
      blue: 0
    }
  end

  def side_text(text, start_x, start_y)
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 127.44, unit: "PT" },
                width: { magnitude: 160.56, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: start_x,
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
              weighted_font_family: { font_family: "Bebas Neue", weight: 800 },
              bold: true,
              font_size: { magnitude: 35, unit: "PT" },
              foreground_color: {
                opaque_color: {
                  rgb_color: white_color
                }
              }
            },
            fields: "*"
          }
        },
        {
          update_paragraph_style: {
            object_id: generated_id,
            style: {
              alignment: "CENTER"
            },
            fields: "alignment"
          }
        }
      ]
    })
  end

  def title_text(text, start_x, start_y)
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 19.80, unit: "PT" },
                width: { magnitude: 181.08, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: start_x,
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
              weighted_font_family: { font_family: "Poppins", weight: 400 },
              font_size: { magnitude: 8, unit: "PT" },
              foreground_color: {
                opaque_color: {
                  rgb_color: white_color
                }
              }
            },
            fields: "*"
          }
        },
        {
          update_paragraph_style: {
            object_id: generated_id,
            style: {
              alignment: "START"
            },
            fields: "alignment"
          }
        }
      ]
    })
  end

  def hexagon(text, start_x, start_y)
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 68.40, unit: "PT" },
                width: { magnitude: 78.48, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: start_x,
                translate_y: start_y,
                unit: "PT"
              }
            },
            shape_type: "HEXAGON"
          }
        },
        {
          update_shape_properties: {
            object_id: generated_id,
            shape_properties: {
              shape_background_fill: {
                property_state: "NOT_RENDERED",
                solid_fill: {
                  color: {
                    rgb_color: black_color
                  },
                  alpha: 1.0
                }
              },
              outline: {
                # property_state: "NOT_RENDERED",
                outline_fill: {
                  solid_fill: {
                    color: {
                      rgb_color: white_color
                    },
                    alpha: 1.0
                  }
                },
                weight: { magnitude: 3, unit: "PT" },
                dash_style: "SOLID"
              },
              content_alignment: "MIDDLE"
            },
            fields: "shapeBackgroundFill.solidFill.color,contentAlignment,outline"
          }
        }
      ]
    })
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 56.52, unit: "PT" },
                width: { magnitude: 65.16, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: start_x + 7,
                translate_y: start_y + 6,
                unit: "PT"
              }
            },
            shape_type: "HEXAGON"
          }
        },
        {
          update_shape_properties: {
            object_id: generated_id,
            shape_properties: {
              shape_background_fill: {
                property_state: "NOT_RENDERED",
                solid_fill: {
                  color: {
                    rgb_color: white_color
                  },
                  alpha: 1.0
                }
              },
              outline: {
                property_state: "NOT_RENDERED",
                outline_fill: {
                  solid_fill: {
                    color: {
                      rgb_color: white_color
                    },
                    alpha: 1.0
                  }
                },
                weight: { magnitude: 1, unit: "PT" },
                dash_style: "SOLID"
              },
              content_alignment: "MIDDLE"
            },
            fields: "shapeBackgroundFill.solidFill.color,contentAlignment,outline"
          }
        }
      ]
    })
    generated_id = generate_id(12)

    presentation.batch_update({
      requests: [
        {
          create_shape: {
            object_id: generated_id,
            element_properties: {
              page_object_id: @slide_id,
              size: {
                height: { magnitude: 58.32, unit: "PT" },
                width: { magnitude: 50.40, unit: "PT" }
              },
              transform: {
                scale_x: 1,
                scale_y: 1,
                translate_x: start_x + 14.04,
                translate_y: start_y - 1.88,
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
              weighted_font_family: { font_family: "Bebas Neue", weight: 600 },
              bold: true,
              font_size: { magnitude: 48, unit: "PT" },
              foreground_color: {
                opaque_color: {
                  rgb_color: black_color
                }
              }
            },
            fields: "*"
          }
        },
        {
          update_paragraph_style: {
            object_id: generated_id,
            style: {
              alignment: "CENTER"
            },
            fields: "alignment"
          }
        }
      ]
    })
  end

  def margin_y
    25.92
  end

  def margin_x
    29.16
  end
end
