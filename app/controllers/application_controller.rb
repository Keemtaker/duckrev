class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.sign_in_count == 1
      football_teams_path
    else
      stored_location_for(resource) || signed_in_root_path(resource)
    end
  end

end
