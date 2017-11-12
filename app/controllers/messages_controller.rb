class MessagesController < ApplicationController

before_action :group_find
before_action :authenticate_user!

  def index
    @messages = Message.where(group_id: params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "メッセージを送信しました"
        redirect_to group_messages_path
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
