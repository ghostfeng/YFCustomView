Pod::Spec.new do |s|
    s.name         = "YFCustomView"
    s.version      = "0.0.1"
    s.summary      = "Some commonly used UI components"
    s.homepage     = "https://github.com/ghostfeng/YFCustomView"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "刘永峰" => "1253289963@qq.com" }
    s.platform     = :ios, "8.0"
    s.ios.deployment_target = '8.0'
    s.requires_arc = true
    s.source       = { :git => "https://github.com/ghostfeng/YFCustomView.git", :tag => "#{s.version}" }
    s.source_files  = 'YFCustomView/YFCustomView.h'
    s.public_header_files = 'YFCustomView/YFCustomView.h'

    s.subspec 'YFMarqueeView' do |ss|
        ss.source_files  = 'YFCustomView/YFMarqueeView/*.{h,m}'
        ss.public_header_files = 'YFCustomView/YFMarqueeView/*.h'
    end
    s.subspec 'YFTextView' do |ss|
        ss.source_files  = 'YFCustomView/YFTextView/*.{h,m}'
        ss.public_header_files = 'YFCustomView/YFTextView/*.h'
    end
    s.subspec 'YFTextField' do |ss|
        ss.source_files  = 'YFCustomView/YFTextField/*.{h,m}'
        ss.public_header_files = 'YFCustomView/YFTextField/*.h'
    end
    s.subspec 'YFCountDownButton' do |ss|
        ss.source_files  = 'YFCustomView/YFCountDownButton/*.{h,m}'
        ss.public_header_files = 'YFCustomView/YFCountDownButton/*.h'
    end
    s.subspec 'YFPageControl' do |ss|
        ss.source_files  = 'YFCustomView/YFPageControl/*.{h,m}'
        ss.public_header_files = 'YFCustomView/YFPageControl/*.h'
    end

    s.frameworks = 'Foundation','UIKit'
end
