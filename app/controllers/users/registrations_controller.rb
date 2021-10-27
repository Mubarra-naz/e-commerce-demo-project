class Users::RegistrationsController < Devise::RegistrationsController
  def create
    build_resource(sign_up_params)
    resource.save

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_to do |format|
          format.js {respond_with resource, location: after_inactive_sign_up_path_for(resource)}
          #format.html {respond_with resource, location: after_inactive_sign_up_path_for(resource)}
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_to do |format|
          format.js {respond_with resource, location: after_inactive_sign_up_path_for(resource)}
          #format.html {respond_with resource, location: after_inactive_sign_up_path_for(resource)}
        end
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_to do |format|
        format.js
      end
    end
  end

end
