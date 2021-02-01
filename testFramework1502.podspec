#
# Be sure to run `pod lib lint testFramework1502.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'testFramework1502'
  s.version          = '0.1.0'
  s.summary          = 'A generic iOS Test Framework Library.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A generic iOS Test Framework library which can be integrated with other Test Suites just by installing a pod.'

  s.homepage         = 'https://github.com/anijain15/testFramework1502'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'anijain15' => 'anirudh.jain@wynk.in' }
  s.source           = { :git => 'https://github.com/anijain15/testFramework1502.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'testFramework1502/Classes/**/*'
  
  # s.resource_bundles = {
  #   'testFramework1502' => ['testFramework1502/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'XCTest'
  # s.dependency 'AFNetworking', '~> 2.3'
end
