#
# Be sure to run `pod lib lint BBCodeString.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BBCodeString"
  s.version          = "0.1.0"
  s.summary          = "BBCodeString is a simple library which enables you to create NSAttributedString object from bb code string."
  s.description      = <<-DESC

BBCodeString is a simple library which enables you to create NSAttributedString object from bb code string.

Example of use:

```objectivec
NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file].";

BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode andLayoutProvider:self];
NSAttributedString *myString = bbCodeString.attributedString;
You can simply set visual attributes for each BB code element by setting layout provider.
```

                       DESC
  s.homepage         = "https://github.com/mrataj/BBCodeString"
  s.license          = 'MIT'
  s.author           = { "Miha Rataj" => "rataj.miha@gmail.com" }
  s.source           = { :git => "https://github.com/mrataj/BBCodeString.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/miharataj'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BBCodeString' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'BBCodeParser', '~> 0.1.0'
end
