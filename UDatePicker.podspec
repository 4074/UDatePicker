Pod::Spec.new do |spec|
  spec.name         = "DatePicker"
  spec.version      = "0.1.0"
  spec.authors      = { "4074" => "fourzerosevenfour@gmail.com" }
  spec.homepage     = "https://github.com/4074/UDatePicker.git"
  spec.summary      = "Simple DatePicker widget in Swift"
  spec.source       = { :git => "https://github.com/4074/UDatePicker.git" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios, '7.0'
  spec.source_files = "UDatePicker.swift"

  spec.requires_arc = true

  spec.ios.deployment_target = '7.0'
  spec.ios.frameworks = ['UIKit']
end