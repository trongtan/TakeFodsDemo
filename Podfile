# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

inhibit_all_warnings!

def common_pods
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'RealmSwift'
  pod 'ObjectMapper'
  pod 'SwiftValidator'
  pod 'SWRevealViewController'
  pod 'AlamofireImage'
  pod 'UIScrollView-InfiniteScroll'
  pod 'SnapKit'
  pod 'AsyncSwift'
  pod 'SwiftSpinner'
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Mockingjay', '1.1.1'
  pod 'Fakery'
end

target 'TakeFods' do
  common_pods
end

target 'TakeFodsTests' do
  common_pods
  testing_pods
end

target 'TakeFodsUITests' do
  common_pods
  testing_pods
  pod 'KIF', '~> 3.0', :configurations => ['Debug']
end
