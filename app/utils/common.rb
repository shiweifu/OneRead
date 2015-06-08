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

    puts("path:", path)


    string = NSString.stringWithContentsOfFile(path,
                                               encoding: NSUTF8StringEncoding,
                                               error: nil)
  end

  def date_to_str(d)
    d.string_with_format('yyyyMMdd', options={:unicode => true})
  end
end


class UIImageView

  def set_image_url(url, placeholder_image=nil)
    placeholder_image = 'placeholder'.uiimage unless placeholder_image.is_a? UIImage
    self.sd_setImageWithURL(url.nsurl, placeholderImage: placeholder_image)
  end

end

