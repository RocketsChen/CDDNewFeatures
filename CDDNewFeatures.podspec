Pod::Spec.new do |s|
s.name         = 'CDDNewFeatures'
s.version      = '1.0.2'
s.summary      = 'A simple new feature integration framework.'
s.description  = "CDDNewFeatures is a very useful wrapper class"
s.homepage     = 'https://github.com/RocketsChen/CDDNewFeatures'
s.license      = { :type => "MIT", :file => "LICENSE" }
s.authors      = {'RcoketsChen' => '1062749739@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/RocketsChen/CDDNewFeatures.git', :tag => '1.0.2'}
s.source_files = "CDDNewFeatures", "CDDNewFeatures/**/*"
s.requires_arc = true

s.framework  = "UIKit"

end
