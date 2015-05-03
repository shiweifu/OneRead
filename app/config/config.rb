# -*- encoding : utf-8 -*-
class Config


  SF_URL   = "http://api.segmentfault.com/article/newest"
  V2EX_URL = "http://www.v2ex.com/api/topics/hot.json"
  JIANSHU_URL = "http://www.jianshu.com"
  CB_URL   = "http://rss.cnbeta.com/rss"

  REFRESH_TITLE = "下拉刷新"

  DEBUG         = true

  def self.init
    color = '#B60900'.uicolor

    UINavigationBar.appearance.tintColor    = color
    UITabBar.appearance.tintColor           = color
    UIToolbar.appearance.tintColor          = color
  end

end
