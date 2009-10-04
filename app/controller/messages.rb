#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class MessageController < AMSController
  map "/messages"

  helper :partial
  helper :auth

  before_all { login_required }

  def sidebar(*args)
  end
  
  def index(id = nil)
    @messages = session_user.messages.select{|msg| msg.read == 0}
    @read_messages = session_user.messages.select{|msg| msg.read == 1}        
    @msg = Message[id.to_i]
    if @msg
      @msg.update(:read => 1)
    end
  end

  def id
    @user = User[id.to_i]
  end

  def reply(mid)
    @msg = Message[mid.to_i]
    @user = @msg.from
  end
  
  def sent
    @messages = Message.filter(:from_id => session_user.id)
    @messages.reverse! if @messages
    @messages ||= []
  end


  def message(id)
    mid = id.to_i
    @message = session_user.messages.select{|msg| msg.id == id}.first
    @target_id = @message.id
  end
  
  def messages(id = nil)
    @messages = session_user.messages.select{|msg| msg.read == 0}.sort_by{|msg| msg.created_at}.reverse #.first 5
    @sent_messages = Message.filter(:from_id => session_user.id).reverse_order(:id).limit 5
    @read_messages = session_user.messages.select{|msg| msg.read == 1}.first 5
    @all_messages = (@messages + @read_messages)
    if id and id=id.to_i
      @message = @all_messages.select{|msg| msg.id == id}.first
      if @message.nil?
        @message = Message[id.to_i]
      end
      @target_id = @message.id
    end
  end
  
  def new(id = nil)
    if id
      @user = User[id.to_i]
    end
  end

  def create
    msg = request.params["msg"]
    session_user.send_msg(session_user, msg["to"], msg["topic"], msg['body'], msg["reply_to_id"])
    redirect MessageController.r(:messages)
  end
  
end


=begin
Local Variables:
  mode:ruby
  fill-column:70
  indent-tabs-mode:nil
  ruby-indent-level:2
End:
=end
