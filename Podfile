# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Marvel_Teste' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'EasyPeasy', '~> 1.6'

  # Pods for Marvel_Teste

  target 'Marvel_TesteTests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
  end

end
