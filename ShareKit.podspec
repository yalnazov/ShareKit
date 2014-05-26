Pod::Spec.new do |s|
  s.name          = 'ShareKit'
  s.version       = '2.5.3'
  s.platform      = :ios, '5.1.1'
  s.summary       = 'Drop in sharing features for all iPhone and iPad apps.'
  s.homepage      = 'http://getsharekit.com/'
  s.author        = 'ShareKit Community'
  s.source        = { :git  => 'https://github.com/ShareKit/ShareKit.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.license       = { :type => 'MIT',
                      :text => %Q|Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n| +
                               %Q|The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n| +
                               %Q|THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE| }
  
  non_arc_files = 'Classes/ShareKit/Core/Helpers/OAuth/**/*.{h,m}', 'Classes/ShareKit/Core/Categories/GTMNSString+HTML.m'

 s.subspec 'Core' do |core|
    core.resource_bundle = {'ShareKit' => ['Classes/ShareKit/Core/SHKSharers.plist', 'Classes/ShareKit/Localization/*.lproj', 'Classes/ShareKit/*.png']}
    core.source_files  = 'Classes/ShareKit/{Configuration,Core,UI}/**/*.{h,m,c}', 'Classes/ShareKit/Sharers/Actions/**/*.{h,m,c}'
    core.exclude_files = non_arc_files
    core.frameworks    = 'SystemConfiguration', 'Security', 'MessageUI', "AVFoundation", "MobileCoreServices", "CoreMedia", "Social"
    core.dependency 'SSKeychain', '~> 1.2.2'
    core.dependency 'SAMTextView', '~> 0.2.1'
    core.dependency 'ShareKit/Reachability'
    core.dependency 'ShareKit/NoARC'
    core.dependency 'SDWebImage'
    core.dependency 'UIActivityIndicator-for-SDWebImage'
  end

  s.subspec 'NoARC' do |noarc|
    noarc.requires_arc = false
    noarc.source_files = non_arc_files
  end

  s.subspec 'Reachability' do |reachability|
    reachability.source_files = 'Classes/ShareKit/Reachability/**/*.{h,m}'
    reachability.requires_arc = false
  end

  s.subspec 'Facebook' do |facebook|
    facebook.source_files   = 'Classes/ShareKit/Sharers/Services/Facebook/**/*.{h,m}'
    facebook.dependency 'Facebook-iOS-SDK'
    facebook.dependency 'ShareKit/Core'
  end

  s.subspec 'LinkedIn' do |linkedin|
    linkedin.source_files = 'Classes/ShareKit/Sharers/Services/LinkedIn/**/*.{h,m}'
    linkedin.dependency 'ShareKit/Core'
  end

  s.subspec 'Tumblr' do |tumblr|
    tumblr.source_files = 'Classes/ShareKit/Sharers/Services/Tumblr/**/*.{h,m}'
    tumblr.dependency 'ShareKit/Core'
  end

  s.subspec 'Twitter' do |twitter|
    twitter.source_files = 'Classes/ShareKit/Sharers/Services/Twitter/**/*.{h,m}'
    twitter.framework = 'Twitter','Social'
    twitter.dependency 'ShareKit/Core'
  end

  s.subspec 'GooglePlus' do |googleplus|
    googleplus.source_files = 'Classes/ShareKit/Sharers/Services/Google Plus/**/*.{h,m}'
    googleplus.vendored_frameworks = 'Frameworks/GooglePlus.framework', 'Frameworks/GoogleOpenSource.framework'
    googleplus.resource = "Frameworks/GooglePlus.bundle"
    googleplus.framework = 'AssetsLibrary', 'CoreLocation', 'CoreMotion', 'CoreGraphics', 'CoreText', 'MediaPlayer', 'Security', 'SystemConfiguration', 'AddressBook'
    googleplus.dependency 'ShareKit/Core'
    googleplus.xcconfig = { 'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/ShareKit/Frameworks/GoogleOpenSource.framework/Versions/A/Headers"' }
  end

  #working version of YouTube subspec. It uses cutting edge Google-API-Client, which is incopatible with current GooglePlus (GooglePlus needs older version). Unfortunately older version of Google-API-Client is not available on CocoaPods. You have to choose between YouTube or GooglePlus - can not use both at the moment, as there would be duplicate symbols (Google-API-Client vs. GoogleOpenSource.framework).

  #s.subspec 'YouTube' do |youtube|
    #youtube.source_files = 'Classes/ShareKit/Sharers/Services/YouTube/**/*.{h,m}'
    #youtube.dependency 'ShareKit/Core'
    #youtube.dependency 'Google-API-Client/Services/YouTube'
    #youtube.dependency 'Google-API-Client/Common'
    #youtube.dependency 'Google-API-Client/Objects'
    #youtube.dependency 'Google-API-Client/Utilities'
  #end

  #This version of GooglePlus subspec can coexist with YouTube. The prerequisite is that GooglePlus.framework can be used with 'Google-API-Client/Services/Plus'. Otherwise we must use GoogleOpenSource.framework, which causes conflicts with youtube subspec

  #s.subspec 'GooglePlus' do |googleplus|
    #googleplus.source_files = 'Classes/ShareKit/Sharers/Services/Google Plus/**/*.{h,m}'
    #googleplus.vendored_frameworks = 'Frameworks/GooglePlus.framework'
    #googleplus.resource = "Frameworks/GooglePlus.bundle"
    #googleplus.framework = 'AssetsLibrary', 'CoreLocation', 'CoreMotion', 'CoreGraphics', 'CoreText', 'MediaPlayer', 'Security', 'SystemConfiguration', 'AddressBook'
    #googleplus.dependency 'ShareKit/Core'
    #googleplus.dependency 'Google-API-Client/Common'
    #googleplus.dependency 'Google-API-Client/Objects'
    #googleplus.dependency 'Google-API-Client/Utilities'
    #googleplus.dependency 'Google-API-Client/Services/Plus'
    #googleplus.dependency 'OpenInChrome'
    #googleplus.dependency 'gtm-logger'
  #end

end
