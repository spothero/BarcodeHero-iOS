# frozen_string_literal: true

Pod::Spec.new do |spec|
  # Root Specification
  spec.name     = 'BarcodeHero'
  spec.version  = '0.4.0'

  spec.author   = { 'SpotHero' => 'ios@spothero.com' }
  spec.homepage = 'https://github.com/SpotHero/BarcodeHero-iOS'
  spec.license  = { type: 'MIT', file: 'LICENSE' }
  spec.source   = { :git => 'https://github.com/SpotHero/BarcodeHero-iOS.git',
                    :tag => spec.version.to_s }
  spec.summary  = 'Allows easy generation of barcodes.'

  # Platform
  spec.ios.deployment_target = '8.0'
  # CocoaPods can't support our current method of implementing BarcodeHeroUI on macOS
  # When Mac Catalyst support is out, we can re-enable this if we want to
  # spec.osx.deployment_target = '10.15'
  spec.swift_versions = ['5.0', '5.1']

  # Build Settings
  # spec.frameworks = 'AVFoundation', 'CoreImage', 'UIKit'
  spec.module_name = 'BarcodeHero'

  # File Patterns
  # spec.source_files = 'BarcodeHero/Core'

  # Subspecs
  spec.default_subspec = 'Core'

  spec.subspec 'Core' do |subspec|
    subspec.source_files = 'Sources/BarcodeHeroCore/**/*.swift'
  end

  spec.subspec 'UI' do |subspec|
    subspec.dependency 'BarcodeHero/Core'

    subspec.source_files = 'Sources/BarcodeHeroUI/**/*.swift'
  end
end
