Pod::Spec.new do |spec|
    # Root Specification
    spec.name     = 'BarcodeHero'
    spec.version  = '0.0.1'

    spec.author   = { 'SpotHero' => 'dev@spothero.com' }
    spec.homepage = 'https://github.com/SpotHero/BarcodeHero-iOS'
    spec.license  = { type: 'Commercial', text: 'Copyright 2017 SpotHero Inc.' }
    spec.source   = { :git => 'https://github.com/SpotHero/BarcodeHero-iOS.git',
                      :tag => spec.version.to_s }
    spec.summary  = 'Allows easy generation of barcodes.'

    # Platform
    spec.platform              = :ios, '10.0'
    spec.ios.deployment_target = '9.0'

    # Build Settings
    spec.module_name = 'BarcodeHero'

    # File Patterns
    spec.source_files = 'BarcodeHero/Core'

    # Subspecs
    spec.default_subspec = 'Core'

    spec.subspec 'Core' do |subspec|
        subspec.source_files = 'BarcodeHero/BarcodeHero/Core/**/*.swift', 'BarcodeHero/BarcodeHero/Extensions/**/*.swift'
    end

    spec.subspec 'UI' do |subspec|
        subspec.dependency 'BarcodeHero/Core'

        subspec.source_files = 'BarcodeHero/BarcodeHero/UI/**/*.swift'
    end
end
