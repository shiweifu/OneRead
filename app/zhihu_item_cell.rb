class ZhihuItemCell < SSBaseTableCell

  def model=(m)
    self.title_label.text = m.name
    print("------images:", m.images)
    self.image_view.set_image_url(m.images[0])
  end

  def self.height_for_model(m)
    95
  end

  def configureCell
    self.contentView.addSubview(self.title_label)
    self.contentView.addSubview(self.image_view)

    self.image_view.pin_to_sueprview_edge_with_offset(:top, 10)
    self.image_view.pin_to_sueprview_edge_with_offset(:trailing, 15)
    self.image_view.pin_size([75, 75])

    self.title_label.pin_to_sueprview_edge_with_offset(:top, 10)
    self.title_label.pin_to_sueprview_edge_with_offset(:leading, 15)
    self.title_label.pin_edge_to_view_edge_with_offset(:trailing, self.image_view, :leading, -10)
  end

  def image_view
    unless @image_view
      @image_view = UIImageView.newAutoLayoutView
    end
    @image_view
  end

  def title_label
    unless @title_label
      @title_label = UILabel.newAutoLayoutView
      @title_label.setFont(UIFont.boldSystemFontOfSize(15))
      @title_label.setNumberOfLines(0)
    end
    @title_label
  end

end
