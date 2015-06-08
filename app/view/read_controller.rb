class ReadController < UIViewController
  include Common

  def viewDidLoad
    @web_view = UIWebView.nw
    @web_view.setBackgroundColor(UIColor.whiteColor)
    view.addSubview(@web_view)
    @web_view.delegate = self
    @web_view.pin_to_superview
    self.title = self.title_text
    load_data

    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAction, target:self, action:"on_action:")
  end

  def webViewDidFinishLoad(webView)
    hide_msg
  end

  def on_action(sender)
    print("more")
  end

  def load_data
    client = Http.new

    if self.type == :sf
      #下载详情
      msg("载入中")
      client.get_json(self.url, params: {}) do |json|
        html = json["data"]["parsedText"]
        load_html(html)
      end

    elsif self.type == :zhihu
      msg("载入中")
      client.get_json(self.url, params: {}) do |json|
        html = json["body"]
        html = html.gsub('<div class="img-place-holder"></div>', "")
        load_html(html)
      end
    end
  end

  def load_html(html)

    if self.type == :sf
      template = read_file("sf_article.html")
    elsif self.type == :zhihu
      template = read_file("zhihu_article.html")
    end

    template = template.gsub("###content###", html)
    # template = template.gsub("%DEVICECLASS%", "iphone")
    template = template.gsub("/img/", "http://segmentfault.com/img/")
    html_body = template

    path = NSBundle.mainBundle.resourcePath;
    baseURL = NSURL.fileURLWithPath(path);

    @web_view.loadHTMLString(html_body, baseURL: baseURL)
  end

  def url
    case self.type
      when :sf
        "http://api.segmentfault.com/article/"  + self.model_id
      when :zhihu
        "http://news-at.zhihu.com/api/4/story/" + self.model_id
      else
        "about:blank"
    end
  end

  def type
    self.params["type"]
  end

  def model_id
    self.params["model_id"]    
  end

  def title_text
    self.params["title"]
  end

  def share_url
    result = ""
    if self.type == :zhihu
      result = "http://daily.zhihu.com/story/" + self.model_id
    end
    result
  end

end
