source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

#Pods
def shared_pods
    
end

#TwitSplit App
target 'TwitSplit' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
