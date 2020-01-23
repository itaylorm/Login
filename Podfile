platform :ios, '9.0'
post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
end

target 'Login' do

use_frameworks!

pod 'RxCocoa'
pod 'RxRelay'
pod 'RxSwift'
pod 'PromiseKit'
pod 'SwiftLint'

end
