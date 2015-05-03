module Common

  def msg(text, type=:normal)
    case type
    when :success
      SVProgressHUD.showSuccessWithStatus(text)
    when :failure
      SVProgressHUD.showFaiulreWithStatus(text)
    else
      SVProgressHUD.showWithStatus(text)
    end
  end

  def hide_msg
    SVProgressHUD.dismiss
  end

  def read_file(filename)
    name, ext =  filename.split(".")

    path = NSBundle.mainBundle.pathForResource(name, ofType: ext)
    string = NSString.stringWithContentsOfFile(path,
                                               encoding: NSUTF8StringEncoding,
                                               error: nil)
  end

  def parse_html(html, selector)
    doc = IGHTMLDocument alloc.initWithXMLString(html, error:nil)
    content = doc.queryWithXPath(selector).firstObject
    content.html
  end

end

