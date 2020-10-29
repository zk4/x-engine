#
# Be sure to run `pod lib lint UniBoost.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UniBoost'
  s.version          = '0.1.0'
  s.summary          = 'A short description of UniBoost.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Ash/UniBoost'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ash' => 'chenzhen01@beantechs.cn' }
  s.source           = { :git => 'https://github.com/Ash/UniBoost.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UniBoost/Classes/**/*'
  
  #customized configure
   s.xcconfig = { 'USER_HEADER_SEARCH_PATHS' => 'UniBoost/Classes/UniApp/Headers/**/*.{h}' }
   s.static_framework = true
   s.ios.vendored_libraries = 'UniBoost/SDKs/libraries/*.a'
   
   s.ios.vendored_frameworks = 'UniBoost/SDKs/frameworks/*.framework'
   
   
   s.libraries ='c++'
   s.frameworks ='JavaScriptCore','CoreMedia','MediaPlayer','AVFoundation','AVKit','GLKit','OpenGLES','CoreText','QuartzCore','CoreGraphics','QuickLook','CoreTelephony','AssetsLibrary','CoreLocation','AddressBook',
   'Photos','CoreMedia'
   
  s.resources = 'UniBoost/Assets/Resources/*.*'
  
  # s.resource_bundles = {
  #   'UniBoost' => ['UniBoost/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
