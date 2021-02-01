class ConversationsController < ApplicationController
  # creating a conversation 
  def create

    @conversation = Conversation.get(current_user.id, params[:user_id])
    # verifying if a conversation is present else it will create new session
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end
  def close
    @conversation = Conversation.find(params[:id])

    session[:conversations].delete(@conversation.id)

    respond_to do |format|
      format.js
    end
  end

  private
  #creates a session for a conversation
  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  def conversated?
    session[:conversations].include?(@conversation.id)
  end

end