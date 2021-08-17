class OrganizationsController < ApplicationController
     def organization_params
        params.require(:organization).permit(:name, :hourly_rate)
    end

    def create
        @organization = Organization.create(organization_params)
        if @organization.save
            User.update(current_user.id, organization_id: @organization.id)
            redirect_to profile_path
        else
            render "sessions#welcome"
        end
    end

    def edit
        @organization = Organization.find(params[:id])
    end

    def update
        @organization = Organization.update(params[:id], organization_params)
        if @organization.errors.any?
            render :edit
        else
            if current_user.organization_id != nil
                redirect_to profile_path
            else
                redirect_to welcome_path
            end
        end
    end

    def destroy
        Organization.destroy(params[:id])
        redirect_to welcome_path
    end
end
