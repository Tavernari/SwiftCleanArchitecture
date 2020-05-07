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

  pod 'Firebase'
  pod 'Firebase/Analytics'

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

  pod 'Firebase'

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

  target 'DataLayerTests' do
  end
end

target 'Analytics' do
  project 'Analytics/Analytics.xcodeproj'
  # use_frameworks!
  use_modular_headers!
  inherit! :search_paths

  pod 'SwiftLint'
  pod 'SwiftFormat/CLI'

  target 'AnalyticsTests' do
  end
end
