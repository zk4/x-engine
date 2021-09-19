Pod::Spec.new do |s|
  s.name             = 'FlutterEngine'
  s.version          = '0.1.0'
  s.summary          = 'FlutterEngine'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/zkty-team/x-engine'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zk' => 'liuzq7@gmail.com' }
  s.source       = { :git => "", :tag => "#{s.version}" }
  s.ios.deployment_target = '9.0'
  s.ios.vendored_frameworks = 'App.framework', 'Flutter.framework'
end
