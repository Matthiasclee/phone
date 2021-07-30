require 'twilio-ruby'

$accountsid = "AC2c2c8c3ecdcbf13dd9bebbf6f9f985dd" #ACCOUNT SID HEERE
$authtoken = "a38d6dd4ab315a1f56ae46fb31c9846b" #AUTH TOKEN HERE
$phone = "+12012989132" #SENDING PHONE NUMBER HERE
def logMSG(phone, body)

if File.exist?("./threads/" + phone + ".thrd")
	File.write("./threads/" + phone + ".thrd", "\n#{Time.now.inspect}█SEND█#{body}", mode: "a")
else
	File.write("./threads/" + phone + ".thrd", "#{Time.now.inspect}█SEND█#{body}", mode: "w")
	if File.exist?("./threads/threads")
		File.write("./threads/threads", "\n" + phone, mode: "a")
	else
		File.write("./threads/threads", phone, mode: "w")
	end
end

return nil
end
def sendSMS(to, body = "No body was send for this message.")

account_sid = $accountsid
auth_token = $authtoken
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages.create(
                             body: body,
                             from: $phone,
                             to: to
)
logMSG(to, body)
return message.sid
end
def call(to, tml = "https://handler.twilio.com/twiml/EHaa77fc48367b411a5f2a2c76f825e83f")
	account_sid = $accountsid
	auth_token = $authtoken
	@client = Twilio::REST::Client.new(account_sid, auth_token)

	call = @client.calls.create(
  	                     url: tml,
  	                     to: to,
   	                    from: $phone
   	                  )
return call.sid
end