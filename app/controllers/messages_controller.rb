class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @messages = Message.where(group_id: params[:group_id])
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "メッセージを送信しました"
        redirect_to group_messages_path
      else
        @group = Group.find(params[:group_id])
        @messages = Message.where(group_id: params[:group_id])
        flash.now[:alert] = "メッセージを入力してください"
        render "index"
      end
  end

  private

   def message_params
     params.require(:message).permit(:body,:image).merge(group_id: params[:group_id]).merge(user_id: current_user.id)
   end


end
