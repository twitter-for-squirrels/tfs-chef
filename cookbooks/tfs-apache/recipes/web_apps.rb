node[:tfs_apache][:web_apps].each do |app|
  web_app app[:server_name] do
    if web_app app[:template]
      template web_app app[:template]
    end
    server_name app[:server_name]
    server_aliases app[:server_aliases]
    docroot app[:docroot]
    app_environment app[:app_environment]
    app_platform app[:app_platform]
    aliases app[:aliases]
  end
end
