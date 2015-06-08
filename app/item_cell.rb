class ItemCell < SSBaseTableCell

  def model=(m)
    self.title_label.text = m.name
    self.desc_label.text = m.excerpt
  end

  def self.height_for_model(m)
    70
  end

  def configureCell
    self.contentView.addSubview(self.title_label)
    self.contentView.addSubview(self.desc_label)

    self.title_label.pin_to_sueprview_edge_with_offset(:top, 10)
    self.title_label.pin_to_sueprview_edge_with_offset(:leading, 15)
    self.title_label.pin_to_sueprview_edge_with_offset(:trailing, 15)

    self.desc_label.pin_edge_to_view_edge_with_offset(:top, self.title_label, :bottom, 5)
    self.desc_label.pin_to_sueprview_edge_with_offset(:leading, 15)
    self.desc_label.pin_to_sueprview_edge_with_offset(:trailing, 15)

  end

  def desc_label
    unless @desc_label
      @desc_label = UILabel.newAutoLayoutView
      @desc_label.numberOfLines = 2
      @desc_label.setFont(UIFont.systemFontOfSize(12))
      @desc_label.setTextColor("#a5abad".to_color)
    end
    @desc_label
  end

  def title_label
    unless @title_label
      @title_label = UILabel.newAutoLayoutView
      @title_label.setFont(UIFont.boldSystemFontOfSize(15))
    end
    @title_label
  end

end