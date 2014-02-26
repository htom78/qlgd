class TenantsController < ApplicationController
	before_filter :current_tenant
	before_filter :login_required

	
	include Pundit
    

	def current_tenant
		Apartment::Database.switch('public')

		if params[:tenant_id].present?
			tenant = Tenant.find(params[:tenant_id])
			Apartment::Database.switch(tenant.name)
			return tenant
		else
			tenant = Tenant.last
			Apartment::Database.switch(tenant.name)
			return tenant
		end
	end
	helper_method :current_tenant
	def login_required
		if is_mobile_device? or is_tablet_device?
			redirect_to new_user_session_path
		end
	end
end