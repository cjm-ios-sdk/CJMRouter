#
# Be sure to run `pod lib lint CJMRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CJMRouter'
  s.version          = '0.1.2'
  s.summary          = '基于UINavigationController的路由器'
  s.description      = <<-DESC
  该路由器是基于UINavigationController实现的，使用原生的控件来导航页面跳转功能，可以简化逻辑和方便使用。
                       DESC

  s.homepage         = 'https://github.com/cjm-ios-sdk/CJMRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenjm' => 'cjiemin@163.com' }
  s.source           = { :git => 'https://github.com/cjm-ios-sdk/CJMRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CJMRouter/Classes/**/*'
  
end
