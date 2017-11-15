class MessagesController < ApplicationController

before_action :group_find

  def index
    @messages = Message.where(group_id: params[:group_id])
    @message = Message.new
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "メッセージを送信しました"
        respond_to do |format|
          format.html { redirect_to group_messages_path }
          format.json
        end
      else
        @messages = Message.where(group_id: params[:group_id])
        flash.now[:alert] = "メッセージを入力してください"
        render "index"
      end
  end

  private

   def message_params
     params.require(:message).permit(:body,:image).merge(group_id: params[:group_id], user_id: current_user.id)
   end

   def group_find
    @group = Group.find(params[:group_id])
   end
end
