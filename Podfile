# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'IOSArchitecture'

target 'Presentation' do
  project 'Presentation/Presentation.xcodeproj'
  use_frameworks!

  # Pods for Presentation
  pod 'R.swift'
  pod 'Alamofire', '~> 5.0'
  pod 'AlamofireImage', '~> 4.0'

  target 'PresentationTests' do
    inherit! :search_paths
  end

  target 'PresentationUITests' do
  end

end

target 'Domain' do
  project 'Domain/Domain.xcodeproj'
  use_frameworks!
  
  # Pods for Presentation
  
  target 'DomainTests' do
    inherit! :search_paths
  end
end

target 'DataSource' do
  project 'DataSource/DataSource.xcodeproj'
  use_frameworks!

  # Pods for Presentation
  pod 'Alamofire', '~> 5'

  target 'DataSourceTests' do
    inherit! :search_paths
  end
end
