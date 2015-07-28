source 'https://github.com/CocoaPods/Specs'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'Movile', :exclusive => true do
    pod 'Alamofire'
    pod 'Result'
    pod 'TraktModels', :git => 'https://github.com/marcelofabri/TraktModels.git'
    pod 'Kingfisher'
    pod 'TagListView'
    pod 'FloatRatingView', :git => 'https://github.com/strekfus/FloatRatingView.git'
    pod 'BorderedView'
    pod 'OverlayView', :git => 'https://github.com/marcelofabri/OverlayView.git'
    pod 'SwiftyUserDefaults'
    pod 'DZNEmptyDataSet'
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Nimble'
  pod 'OHHTTPStubs'
end

