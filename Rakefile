# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap/all'
# require 'sugarcube'
# require 'sugarcube-nsdate'
require 'sugarcube-all'
require 'sugarcube-repl'
require 'motion-cocoapods'
require 'afmotion'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'OneRead'
#  app.libs += %w(/usr/lib/libxml2.2.dylib)

  app.identifier = 'me.lonelygod.oneread'
  app.provisioning_profile = '/Users/shiweifu/oneread.mobileprovision'
  app.codesign_certificate = 'iPhone Developer: Weifu Shi (JRXWYDYYSD)'
                              

  app.pods do
    pod 'STHTTPRequest'
    pod 'PureLayout'
    pod 'SDWebImage'
    pod 'SSDataSources'
    pod 'SWRevealViewController'
    pod 'HHRouter'
    pod 'SVProgressHUD'
    pod 'openshare'
  end

end
