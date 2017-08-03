Pod::Spec.new do |s|
  s.name             = 'NSStringMask'
  s.version          = '1.2.2'
  s.summary          = 'NSStringMask enables you to apply masks or formats to NSStrings using NSRegularExpression to input your format.'

  s.description      = <<-DESC
This tiny library was developed to help you apply masks and formats to strings.

For instance, suppose you have the string `12345678` and want to format it as a Social Security Number (which regex pattern is `\d{3}-\d{2}-\d{3}`). With NSStringMask, all you have to do is `[NSStringMask maskString:@"12345678" withPattern:@"(\\d{3})-(\\d{2})-(\\d{3})"]` and the result will be "123-45-678". Simple enough?
                       DESC

  s.homepage         = 'https://github.com/fjcaetano/NSStringMask'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Flávio Caetano' => 'flavio@vieiracaetano.com' }
  s.source           = { :git => 'https://github.com/fjcaetano/NSStringMask.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/flavio_caetano'

  s.ios.deployment_target = '4.0'

  s.source_files = 'NSStringMask/Classes/**/*'
end
