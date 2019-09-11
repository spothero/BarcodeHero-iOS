Pod::Spec.new do |spec|
  # Root Specification
  spec.name     = 'BarcodeHero'
  spec.version  = '0.3.2'

  spec.author   = { 'SpotHero' => 'dev@spothero.com' }
  spec.homepage = 'https://github.com/SpotHero/BarcodeHero-iOS'
  spec.license  = { type: 'Commercial', text: 'Copyright 2019 SpotHero Inc.' }
  spec.source   = { :git => 'https://github.com/SpotHero/BarcodeHero-iOS.git',
                    :tag => 'v' + spec.version.to_s }
  spec.summary  = 'Allows easy generation of barcodes.'

  # Platform
  spec.platform = :ios, '10.0'

  # Build Settings
  # spec.frameworks = 'AVFoundation', 'CoreImage', 'UIKit'
  spec.module_name = 'BarcodeHero'

  # File Patterns
  # spec.source_files = 'BarcodeHero/Core'

  # Subspecs
  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |subspec|
    subspec.source_files = 'BarcodeHero/BarcodeHero/Core/**/*.swift'
  end

  spec.subspec 'UI' do |subspec|
    subspec.dependency 'BarcodeHero/Core'

    subspec.source_files = 'BarcodeHero/BarcodeHero/UI/**/*.swift'
    subspec.resources    = 'BarcodeHero/BarcodeHero/UI/**/*.xib', 'BarcodeHero/BarcodeHero/UI/**/*.xcassets'
  end
end
