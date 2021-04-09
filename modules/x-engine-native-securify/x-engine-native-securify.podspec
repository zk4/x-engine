#
#  Be sure to run `pod spec lint JsApiTest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#


Pod::Spec.new do |s|


    s.name         = "x-engine-native-securify"
    s.version      = "1.0.0"
    s.summary      = "x-engine-native-securify" 

     s.description  = <<-DESC
            description
                     DESC

    s.homepage     = "https://github.com/zkty-team/x-engine-native-securify"


   
    s.license      = { :type => "MIT", :file => "LICENSE" }

    s.requires_arc = true

    s.author             = { "zkty-team" => "liuzq7@gmail.com" }

    s.cocoapods_version      = ">= 1.2.0"
    s.platform     = :ios, "10.0"
    s.ios.deployment_target = "10.0"

    s.source      = { :git => 'https://github.com/zkty-team/x-engine-native-securify.git',
  :tag => s.version.to_s }


    s.source_files  = "iOS/Class/**/*.{h,m}"
    s.public_header_files = "iOS/Class/**/*.h"
   
    s.frameworks  = "CoreServices"

    # 不需pod 仓库里有文件，只需要在 Podifle 指定本地路径即可
    # https://stackoverflow.com/questions/16905112/cocoapods-dependency-in-pod-spec-not-working
    s.dependency "x-engine-native-core"
    s.dependency "x-engine-native-protocols"
    
    s.pod_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
end

