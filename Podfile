platform :ios, '16.0'

flutter_application_path = '../movies_flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'MoviesiOSApp' do
  install_all_flutter_pods(flutter_application_path)

  target 'MoviesiOSAppTests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
