# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'IOSArchitecture'

target 'PresentationLayer' do
  project 'PresentationLayer/PresentationLayer.xcodeproj'
  use_frameworks!
  # use_modular_headers!

  pod 'R.swift'
  pod 'Alamofire', '~> 5.0'
  pod 'AlamofireImage', '~> 4.0'
  pod 'Swinject'
  pod 'SwiftLint'
	pod 'SwiftFormat/CLI'

  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '5.0.2'

  pod 'Firebase'
  pod 'Firebase/Analytics'
  pod 'Firebase/Performance'

  target 'PresentationLayerTests' do
    pod "SwiftyMocky"
  end

  target 'PresentationLayerUITests' do
    pod 'SwiftLocalhost'
  end

end

target 'PresentationSwiftUI' do
  project 'PresentationSwiftUI/PresentationSwiftUI.xcodeproj'
  use_frameworks!
  # use_modular_headers!

  pod 'R.swift'
  pod 'Alamofire', '~> 5.0'
  pod 'AlamofireImage', '~> 4.0'
  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'

  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '5.0.2'

  pod 'Firebase'
  pod 'Firebase/Analytics'

  pod 'Firebase/Performance'

  target 'PresentationSwiftUITests' do
  end

  target 'PresentationSwiftUIUITests' do
    pod 'SwiftLocalhost'
  end
end

target 'DomainLayer' do
  project 'DomainLayer/DomainLayer.xcodeproj'
  use_frameworks!
  # use_modular_headers!

  pod 'SwiftLint'
	pod 'SwiftFormat/CLI'
  
  target 'DomainLayerTests' do
    inherit! :search_paths
    pod "SwiftyMocky"
  end
end

target 'DataLayer' do
  project 'DataLayer/DataLayer.xcodeproj'
  # use_frameworks!
  use_modular_headers!
  inherit! :search_paths

  pod 'Alamofire', '~> 5'
  pod 'SwiftLint'
	pod 'SwiftFormat/CLI'

  pod 'Firebase/RemoteConfig'

  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'

  target 'DataLayerTests' do
  end
end

target 'Lytics' do
  project 'Lytics/Lytics.xcodeproj'
  # use_frameworks!
  use_modular_headers!
  inherit! :search_paths

  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'

  target 'LyticsTests' do
  end
end
