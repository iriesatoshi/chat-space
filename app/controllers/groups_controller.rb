class GroupsController < ApplicationController

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

  end

  def update

  end

    private

   def group_params
     params.require(:group).permit(:group_name, user_ids: [])
   end


end