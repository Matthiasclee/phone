require "twilio-ruby"
$accountsid = "AC2c2c8c3ecdcbf13dd9bebbf6f9f985dd" #ACCOUNT SID HEERE
$authtoken = "a38d6dd4ab315a1f56ae46fb31c9846b" #AUTH TOKEN HERE
$phone = "+19287560859" #SENDING PHONE NUMBER HERE
	account_sid = $accountsid
	auth_token = $authtoken
	@client = Twilio::REST::Client.new(account_sid, auth_token)

	call = @client.calls.create(
  	                     url: "https://handler.twilio.com/twiml/EHbdcc2e629c62589d317b3b80dabd2f0a",
  	                     to: gets.chomp,
   	                    from: $phone
   	                  )
return call.sid