#
# Be sure to run `pod lib lint LCRNetServiceKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LCRNetServiceKit'
  s.version          = '0.1.18'
  s.summary          = '更新依赖库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/LinChengRain/LCRNetServiceKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LinChengRain' => 'yuchanglinlin@163.com' }
  s.source           = { :git => 'https://github.com/LinChengRain/LCRNetServiceKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.source_files = 'Sources/Classes/**/*'
  s.resource_bundles = {"LCRNetServiceKit" => ["Sources/PrivacyInfo.xcprivacy"]}
  s.swift_versions = '5.2'
  s.platform = :ios,'12.0'
  # s.resource_bundles = {
  #   'LCRNetServiceKit' => ['LCRNetServiceKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 5.10.2'
  s.dependency 'ReachabilitySwift', '~> 5.2.4'

end
