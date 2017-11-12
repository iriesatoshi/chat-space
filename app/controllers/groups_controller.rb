class GroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group = Group.new
  end


  def create
    @group = Group.new(group_params)
    if @group.save
    redirect_to root_path
    flash[:notice] = "グループを作成しました"
    else
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
      if @group.update(group_params)
        redirect_to root_path
        flash[:notice] = "グループを更新しました"
      else
        render "edit"
        flash[:alert] = "エラーがあります"
      end
  end

    private

   def group_params
     params.require(:group).permit(:group_name, user_ids: [])
   end


end
