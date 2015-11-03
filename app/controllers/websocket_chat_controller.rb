# WebsocketRails::BaseControllerを継承

class WebsocketChatController < WebsocketRails::BaseController

	def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def new_message
    logger.debug("Call new_message : #{message}")

    channel_name = message.channel_name
    WebsocketRails["#{channel_name}"].trigger(:new_message, message) 
  end

end