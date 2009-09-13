#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class MessageController < AMSController
  map "/messages"

  helper :partial
  
  def index(id = nil)
    @messages = session_user.messages.select{|msg| msg.read == 0}
    @read_messages = session_user.messages.select{|msg| msg.read == 1}        
    @msg = Message[id.to_i]
    if @msg
      @msg.update(:read => 1)
    end
  end

  def sent
    @messages = Message.filter(:from_id => session_user.id)
    @messages.reverse! if @messages
    @messages ||= []
  end
  
  def messages_for(uid)
    @messages = session_user.messages.select{|msg| msg.read == 0}    
    @sent_messages = Message.filter(:from_id => session_user.id)
    @read_messages = session_user.messages.select{|msg| msg.read == 1}    
  end
  
  def new(id = nil)
    if id
      @user = User[id.to_i]
    end
  end

  def create
    msg = request.params["msg"]
    session_user.send_msg(session_user, msg["to"], msg["topic"], msg['body'])
    redirect MessageController.r(:messages_for, session_user.id)
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
