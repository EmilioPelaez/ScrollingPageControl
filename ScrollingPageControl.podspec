#
# Be sure to run `pod lib lint ScrollingPageControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollingPageControl'
  s.version          = '0.1.1'
  s.summary          = 'A custom page control that shows a maximum number of dots and scrolls to reveal more.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ScrollingPageControl is a custom page control that shows a maximum number of dots and scrolls to reveal more.
It's inspired by Instagram implementation of the page control.
                       DESC

  s.homepage         = 'https://github.com/EmilioPelaez/ScrollingPageControl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'EmilioPelaez' => 'i.am@emiliopelaez.me' }
  s.source           = { :git => 'https://github.com/EmilioPelaez/ScrollingPageControl.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/EmilioPelaez'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/**/*.swift'

  s.frameworks = 'UIKit'

  s.swift_version = '4.2'
end
