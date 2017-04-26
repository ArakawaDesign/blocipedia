class WikisController < ApplicationController
  before_action :authorize_user, except: [:index, :show, :edit, :update, :new, :create]
  
  def index
      if User.find(current_user.id).member? 
        @wikis = Wiki.where(private: false)
        @collab_wikis = current_user.collaborated_wikis
      else
        @wikis = Wiki.all
      end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end
  
  def new
    @user = current_user
    @wiki = Wiki.new
  end
  
  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
    @collaborator = Collaborator.new
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    
    @wiki.assign_attributes(wiki_params)
    @wiki.user_ids = params[:wiki][:user_ids] if params[:wiki][:user_ids].present?
    
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id]).delete
    
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private
  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to wikis_path
    end
  end
  
  def allow_premium
    unless current_user.admin? || current_user.premium?
      flash[:alert] = "Sign up for a premium account to create wikis!"
      redirect_to wikis_path
    end
  end
  #def make_private
  #  @wiki = Wiki.new
  #  @wiki.private = params[:private]
  #end
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user, :user_ids)
  end
end
