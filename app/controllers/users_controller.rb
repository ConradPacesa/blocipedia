class UsersController < ApplicationController
  def downgrade
    @user = User.find(params[:id])
    @user.role = 'standard'

    if @user.save
      flash[:notice] = "You have been downgraded. You private wikis are now public."
      redirect_to root_path
    else
      flash[:alert] = "There was an error updating your prfile, try again."
      redirect_to root_path
    end
  end
end
