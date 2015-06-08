class Http

  def get(url, params, &callback)
    AFMotion::HTTP.get(url, params=params) do |result|
      callback.call(result.object)
    end
  end

  def get_json(url, params, &callback)
    AFMotion::JSON.get(url, params=params) do |result|
      callback.call(result.object)
    end
  end

  def get_url(url)
    puts("-------get url:", url)
    u = NSURL.alloc.initWithString(url)
    NSString.stringWithContentsOfURL(u)
  end


  # def get(url, params, &callback)
  #
  #   # AFMotion::HTTP:
  #
  #
  #   url = get_url(url)
  #   p "GET:#{url} - #{params.to_s}" if Config::DEBUG
  #
  #   BW::HTTP.get(url, {payload: params}) do |response|
  #     if response.ok?
  #       json = BW::JSON.parse(response.body.to_str)
  #       callback.call(json)
  #     elsif response.status_code.to_s =~ /40\d/
  #       p "网络获取数据错误:#{response.status_code.to_s}"
  #       callback.call(nil)
  #     else
  #       p "网络获取数据错误:#{response.error_message}"
  #       callback.call(nil)
  #     end
  #   end
  # end
  #
  # def post(url, params, &callback)
  #   url = get_url(url)
  #   p "POST:#{url} - #{params.to_s}" if Config::DEBUG
  #
  #   BW::HTTP.post(url, {payload: params}) do |response|
  #     if response.ok?
  #       json = BW::JSON.parse(response.body.to_str)
  #       callback.call(json)
  #     elsif response.status_code.to_s =~ /40\d/
  #       p "网络获取数据错误:#{response.status_code.to_s}"
  #       callback.call(nil)
  #     else
  #       p "网络获取数据错误:#{response.error_message}"
  #       callback.call(nil)
  #     end
  #   end
  # end
  #
  # def get_url(url)
  #   url = url.downcase
  #   return url if url.include? "http:" || Config::BASE_URL.nil?
  #   Config::BASE_URL + url
  # end

end