platform :ios, '13.0'

target 'Buzz Shorts' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Buzz Shorts

pod 'Firebase/Database'
pod 'Firebase/Storage'

pod 'SideMenu'
pod 'SDWebImage'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
    end
  end
end
