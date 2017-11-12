require 'rails_helper'
require 'support/controller_macros'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group)}
  let(:message) { create(:message)}
  let(:group_id) do
    {params: { group_id: group.id }}
  end
  let(:params) do
    { params: { group_id: group.id, message: attributes_for(:message) } }
  end
  let(:messages){ create_list(:message, 3, group_id: message.group_id) }

  describe 'GET #index' do

      subject{
        Proc.new{ get :index, params: { group_id: messages.first.group_id } }
      }

    context "after login" do
      before do
        login_user user
      end

      it "populates an array of messages" do
        subject.call
        expect(assigns(:messages).to_a[1..3]).to match(messages)
      end

      it "populates an array of message" do
        get :index, params: { group_id: group }
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "renders the :index template" do
        subject.call
        expect(response).to render_template :index
      end
    end
    context "before login" do
      it "renders the new_user_session_path template" do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'Post #create' do
    subject{
        Proc.new{ post :create, params }
      }
    context "ログインしている時" do
      before do
        login_user user
      end
      context "@messageが保存できた時" do

        it "データベースに値が保存される" do
          expect{subject.call}.to change(Message, :count).by(1)
        end

        it "正しいビューに変遷する" do
          subject.call
          expect(response).to redirect_to group_messages_path
        end

      end

      context "@messageが保存できなかった時" do

        it "データベースに値が保存されない" do
          expect{post :create, params: { group_id: group.id, message: attributes_for(:message, body: nil, image: nil) }}.to change(Message, :count).by(0)
        end

        it "正しいビューに変遷する" do
          subject.call
          expect(response).to redirect_to group_messages_path
        end

      end
    end
    context "ログインしていない時" do
      it '正しいビューに変遷する'do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
