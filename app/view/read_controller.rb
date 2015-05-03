
class ReadController < UIViewController
  include Common

  attr_accessor :type, :model

  def viewDidLoad
    @web_view = UIWebView.nw
    view.addSubview(@web_view)
    @web_view.pin_to_superview
    load_data
  end

  def load_data
    client = Http.new

    if @type == :sf
      #下载详情
      client.get_json(self.url, params:{}) do |json|
        html = json["data"]["parsedText"]

        template = read_file("clipy-template.html")
        template = template.gsub("%BODY%", html)
        template = template.gsub("%DEVICECLASS%", "iphone")
        template = template.gsub("/img/", "http://segmentfault.com/img/")
        html_body = template

        @web_view.loadHTMLString(html_body, baseURL:nil)
      end

    end
  end

  def url
    case @type
      when :sf
        "http://api.segmentfault.com/article/" + @model.id
      when :cnbeta
        "http://www.cnbeta.com/articles/390459.htm"
      else
        "about:blank"
    end
  end

end