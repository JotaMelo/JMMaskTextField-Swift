#
# Be sure to run `pod lib lint JMMaskTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'JMMaskTextField-Swift'
s.version          = '0.1.0'
s.summary          = 'JMMaskTextField - text field masking the easy way'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
JMMaskTextField makes creating masked UITextFields as easy as setting a mask string, like (000) 000-0000 for phone numbers, or AAA-0000 for a Brazilian license plate.
JMMaskTextField supports pasting, inserting and deleting from the middle.
DESC

s.homepage         = 'https://github.com/JotaMelo/JMMaskTextField-Swift'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Jota Melo' => 'jpmfagundes@gmail.com' }
s.source           = { :git => 'https://github.com/JotaMelo/JMMaskTextField-Swift.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/Jota'

s.ios.deployment_target = '8.0'

s.source_files = 'JMMaskTextField/Classes/**/*'
end
