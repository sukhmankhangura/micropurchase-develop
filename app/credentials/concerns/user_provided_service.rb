module UserProvidedService
  def credentials(service_name)
    user_provided_service(service_name) && user_provided_service(service_name)['credentials']
  end

  def use_env_var?
    true
    # Rails.env.development? || Rails.env.test?
  end

  def user_provided_service(name)
    user_provided_services.find { |service| service['name'] == name }
  end

  def user_provided_services
    []
  end
end
