Pod::Spec.new do |s|
 s.name		= 'LYTools'
 s.version	= '1.0.4'
 s.summary	= 'LYTools 是一组实用工具总结，多为在OC中使用比较方便的工具类，在此用Swift实现'
 s.homepage	= 'https://github.com/ly92/LYTools'
 s.license	= 'MIT'
 s.platform	= :ios
 s.author	= {'ly92' => '1364757394@qq.com'}
 s.ios.deployment_target = '8.0'
 s.source	= {:git => 'https://github.com/ly92/LYTools.git',:tag => s.version}
 s.source_files = 'Tools/*.{swift}'
 s.resources	= 'Tools/resource/*.{jpeg,png,xib,nib,bundle}'
 s.requires_arc = true
 s.frameworks	= 'UIKit'
end
