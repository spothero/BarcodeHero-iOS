source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!

workspace 'BarcodeHero.xcworkspace'

target 'BarcodeHero' do
    project 'BarcodeHero/BarcodeHero.xcodeproj'
end

target 'BarcodeHeroDemo' do
    project 'BarcodeHero/BarcodeHero.xcodeproj'

    pod 'BarcodeHero', :subspecs => ['Core', 'UI'], :path => '.'

    target 'BarcodeHeroTests'
end
