#
#
# Author:  Michael 'entropie' Trommer <mictro@gmail.com>
#

class MessageController < AMSController
  map "/messages"

  helper :partial
  
  def index(id = nil)
    @messages = Message.all
    @msg = Message[id.to_i]
  end
  
  def messages_for(uid)
    @messages = session_user.messages
  end
  
  def inbox(uid = nil)
    @messages = session_user.messages
  end

  def new(id = nil)
    if id
      @user = User[id.to_i]
    end
  end

  def create
    msg = request.params["msg"]
    session_user.send_msg(msg["to"], msg["topic"], msg['body'])
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
