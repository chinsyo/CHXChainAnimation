# CHXChainAnimation

Pod::Spec.new do |s|

  s.name         = "CHXChainAnimation"
  s.version      = "1.0.0"
  s.summary      = "An library easy to read and write chainable animations in Objective-C"
  s.homepage     = "https://github.com/chinsyo/CHXChainAnimation"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Chinsyo" => "http://weibo.com/chinsyo" }

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/chinsyo/CHXChainAnimation.git", :tag => "#{s.version}" }
  s.source_files  = "Class/*.{h,m,c}"
  s.requires_arc = true

end
