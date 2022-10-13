class WhatsappManager
  def initialize
    # @client = WhatsappSdk::Api::Client.new(Figaro.env.whatsapp_token.to_s) #? FIX: token is invalid passing figaro envç
    client = WhatsappSdk::Api::Client.new('EAAP7zxmZBCsUBAGgCAbpZCmj0DIJiHjaikIjF8lYAjfeQAGYyJkKLwPRI5H9cCvQsUySn1LJ5e81Fs5rIfjmGxLmw4hRwSZBVHfZA7DLwmUTvBSzrmrGrnDTPEh1hLZAR08a8DahHnPUli2DZCiZBUW9Re9bT6cDZBHHzOEcZC7AOsFMBwBJTjVkFNFO3mjmJwgiwdIHP7ZBZA07AZDZD')
    @messages_api = WhatsappSdk::Api::Messages.new(client)
    phone_numbers_api = WhatsappSdk::Api::PhoneNumbers.new(client)
    
    @registered_number  = phone_numbers_api.registered_number(Figaro.env.whatsapp_sender_id.to_i)
    @registered_numbers = phone_numbers_api.registered_numbers(Figaro.env.whatsapp_business_id.to_i)
  end
  
  
  def create_body(*params)
    body_component = WhatsappSdk::Resource::Component.new(type: WhatsappSdk::Resource::Component::Type::Body)
    params.each do |param|
      obj = WhatsappSdk::Resource::ParameterObject.new(
        type: "text",
        text: param.to_s
      )
      body_component.add_parameter(obj)
    end
    body_component.to_json
  end

  # template: template`s name created on facebook.developers panel
  # sender_id: phone number from send message
  # recipient_number: phone number to send message
  # params: data to replace in template, 
  # lookat documentation to know which param is required in each template
  def send_message(template, recipient, *params)
    sender = Figaro.env.whatsapp_sender_id.to_i
    body = create_body(*params)
    @messages_api.send_template(
      sender_id: sender,
      recipient_number: recipient,
      name: template, 
      language: "en_US", 
      components: [
        body
      ]
    )
  end
end