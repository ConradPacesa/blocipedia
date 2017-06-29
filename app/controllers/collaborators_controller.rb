class CollaboratorsController < ApplicationController

  before_action :get_wiki

  def index
    @users = User.all
  end

  def new
    @collaborator = Collaborator.new
  end

  def create
    @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: params[:user_id])

    if @collaborator.save
      flash[:notice] = "collaborator has been added as a collaborator to wiki."
      redirect_to wiki_collaborators_path(@wiki)
    else
      flash[:alert] = "There was an error adding the collaborator. Please try again."
      render :new
    end
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator was successfully removed."
    else
      flash[:alert] = "There was an error removing the collaborator. Please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  private
  def get_wiki
    @wiki = Wiki.friendly.find(params[:wiki_id])
  end
end
