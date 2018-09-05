Pod::Spec.new do |s|
s.name             = 'JMMaskTextField-Swift'
s.version          = '0.1.3'
s.summary          = 'JMMaskTextField - text field masking the easy way'

s.description      = <<-DESC
JMMaskTextField makes creating masked UITextFields as easy as setting a mask string, like (000) 000-0000 for phone numbers, or AAA-0000 for a Brazilian license plate.
JMMaskTextField supports pasting, inserting and deleting from the middle.
DESC

s.homepage         = 'https://github.com/JotaMelo/JMMaskTextField-Swift'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Jota Melo' => 'jpmfagundes@gmail.com' }
s.source           = { :git => 'https://github.com/JotaMelo/JMMaskTextField-Swift.git', :tag => s.version.to_s }
s.social_media_url = 'https://twitter.com/Jota'

s.ios.deployment_target = '8.0'

s.source_files = 'JMMaskTextField/Classes/**/*'
end
