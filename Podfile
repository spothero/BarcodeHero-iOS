source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!

workspace 'BarcodeHero.xcworkspace'

target 'BarcodeHero' do
    project 'BarcodeHero/BarcodeHero.xcodeproj'

    pod 'SwiftLint', '~> 0.27.0'

    target 'BarcodeHeroTests'
end

target 'BarcodeHeroDemo' do
    project 'BarcodeHero/BarcodeHero.xcodeproj'

    podspec :path => './BarcodeHero.podspec'
end
