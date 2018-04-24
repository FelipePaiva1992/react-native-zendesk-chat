require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name = package['name']
  s.version = package['version']
  s.summary = package['description']
  s.description = package['description']
  s.homepage = package['homepage']
  s.license = package['license']
  s.author = package['author']
  s.source = { :git => 'https://github.com/fjtrujy/react-native-zendesk-chat.git', :tag => s.version }

  s.platform = :ios, '9.0'
  s.ios.deployment_target = '8.0'

  s.source_files  = "ios/**/*.{h,m}"

  s.dependency 'React'
  s.dependency 'ZDCChat', '~> 1.3.7.1'

end