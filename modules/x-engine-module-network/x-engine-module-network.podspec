#
#  Be sure to run `pod spec lint JsApiTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


    s.name         = "x-engine-module-network"
    s.version      = "0.0.4"
    s.summary      = "网络模块打包和方法调用"

     s.description  = <<-DESC
      测试模块打包和方法调用针对模块化应用和功能
                     DESC

    s.homepage     = "https://github.com/zkty-team/x-engine-module-network"

    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.requires_arc = true

    s.author             = { "zkty-team" => "liuzq7@gmail.com" }

    s.platform     = :ios, "10.0"
    s.ios.deployment_target = "10.0"

    s.source      = { :git => 'https://github.com/zkty-team/x-engine-module-network.git',
  :tag => s.version.to_s }

    s.source_files  = "iOS/Class/**/*.{h,m}"
    s.public_header_files = "iOS/Class/**/*.h"
   
    s.frameworks  = "UIKit"

    s.pod_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
    s.dependency 'x-engine-module-engine'
    s.dependency 'x-engine-module-protocols'
    s.dependency 'AFNetworking', '~> 4.0.0'
    #s.dependency 'SSZipArchive'
   # s.dependency 'JSONModel'
   


end
