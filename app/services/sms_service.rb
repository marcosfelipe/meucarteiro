class SmsService

  def initialize()

    @client = RestClient::Resource.new "http://173.44.33.18/painel/api.ashx"

    begin
      @api_user = Rails.application.secrets.sms_user
      @api_pass = Rails.application.secrets.sms_pass
    rescue Exception => e
      puts e.message
      puts "Sms secrets not found, check secrets.yml!"
    end

  end

  def send_one(number, message)

    @client.get :params => {:action => 'sendsms', :lgn => @api_user, :pwd => @api_pass, :msg => message, :numbers => number}



    #uri = Addressable::URI.new
    #uri.query_values = {:action => 'sendsms', :lgn => @api_user, :pwd => @api_pass, :msg => message, :numbers => number}
    #uri = "#{@url}#{uri.query}"
    #puts @url
    #puts uri
    #result = URI.parse(uri).read
    #puts result

  end


end