Pod::Spec.new do |s|
  s.name         = "STTabBarController"
  s.version      = "0.0.2"
  s.summary      = "STTabbarController is a highly customizable TabbarController！"
  s.description  = "TabbarController CustomTabbarController Tabbar customizable STTabbarController."
  s.homepage     = "https://github.com/YQ-Seventeen/STTabbarController.git"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "yq-seventeen" => "yl616775291@163.com" }
  s.platform     = :ios, '8.0'
  s.source       = { :git => "https://github.com/YQ-Seventeen/STTabbarController.git", :tag => "#{s.version}" }
  s.source_files  = 'STTabbarController', 'STTabbarController/**/*.{h,m}'
  s.framework = 'UIKit', 'Foundation'
  s.requires_arc = true
end
