Pod::Spec.new do |spec|
  spec.name         = "UDatePicker"
  spec.version      = "1.0.0"
  spec.authors      = { "4074" => "fourzerosevenfour@gmail.com" }
  spec.homepage     = "https://github.com/4074/UDatePicker.git"
  spec.summary      = "A date picker widget written in Swift which is lightweight and extensible."
  spec.source       = { :git => "https://github.com/4074/UDatePicker.git", :tag => "1.0.0" }
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios, '7.0'
  spec.source_files = "UDatePicker.swift"

  spec.requires_arc = true

  spec.ios.deployment_target = '8.0'
  spec.ios.frameworks = ['UIKit']
end
