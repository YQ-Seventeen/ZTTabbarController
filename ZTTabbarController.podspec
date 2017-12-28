Pod::Spec.new do |s|
  s.name         = "ZTTabbarController"
  s.version      = "0.0.2"
  s.summary      = "ZTTabbarController is a highly customizable TabbarController！"
  s.description  = "TabbarController CustomTabbarController Tabbar customizable ZTTabbarController."
  s.homepage     = "https://github.com/YQ-Seventeen/ZTTabbarController.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "yq-seventeen" => "yl616775291@163.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/YQ-Seventeen/ZTTabbarController.git", :tag => "#{s.version}" }
  s.source_files  = 'ZTTabbarController', 'ZTTabbarController/**/*.{h,m}'
  s.framework = 'UIKit', 'Foundation'
  s.requires_arc = true
end
