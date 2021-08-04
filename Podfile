# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

workspace 'AloTips.xcworkspace'
project 'AloTips.xcodeproj'

def networking_pod
  pod 'Networking', :path => 'DevPods/Networking'
end

def development_pods
  networking_pod
end

target 'AloTips' do
  use_frameworks!
  # Pods for App
  development_pods
end

target 'AloTipsTests' do
  use_frameworks!
  
  # Pods for testing
  development_pods
end

target 'Networking_Example' do
  use_frameworks!
  project 'DevPods/Networking/Example/Networking.xcodeproj'
  
  networking_pod
end
