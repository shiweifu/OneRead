class Item
  attr_accessor :id, :name, :time, :created_date, :excerpt, :tags, :link, :images

  def initialize(json={})
    @id           = json[:id]
    @name         = json[:title]
    @time         = json[:votes]
    @excerpt      = json[:excerpt]
    @tags         = json[:tags]
    @created_date = json[:createdDate]
    @link         = json[:link]
    @images       = json[:images]
  end
end