class WikisController < ApplicationController

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = 'You have successfully created a new wiki.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error creating your wiki. Please try again.'
      render :new
    end
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    authorize @wiki

    if @wiki.save
      flash[:notice] = 'You have successfully updated your wiki.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error updating your wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.destroy

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was successfully deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(new_user_session_path)
  end
end
