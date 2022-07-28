Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.name = "EBSSwiftUtils"
  s.summary = "EBSSwiftUtils"
  s.requires_arc = true

  s.version = "1.4"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author  = { "Ivan" => "ivan.postolaki@gmail.com" }
  s.homepage = "https://git2.devebs.net/ebs-mobile/ios/swift-utils"
  s.source = { :git => "https://git2.devebs.net/ebs-mobile/ios/swift-utils.git", :tag => s.version.to_s}

  s.swift_version = "5.0"
  s.frameworks = "Foundation", "UIKit"

  s.source_files = "SwiftUtils/**/*.{swift,h,m}"
end
