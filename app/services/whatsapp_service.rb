class WhatsappService

  def initialize()

    @client = RestClient::Resource.new "http://portal.whatsbulk.com"

    begin
      @token = Rails.application.secrets.whatsapp_token
    rescue Exception => e
      puts e.message
      puts "Whatsapp token not found, check your secrets.yml!"
    end

  end

  def send_one(number, message)

    @client['api_sendToNumbers'].post({
      "APIKey" => @token,
      "messageType" => "single",
        "services" => {
          "name" => "WhatsApp",
          "NoSendTime" => {
            "BaseHour" => "00=>00",
            "For" => 6
          },
          "selectedNumbers" => [number],
          "messages" => [{"type" => "Text","content" => message}]
        }
    })

  end


end