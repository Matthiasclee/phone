require "sinatra"
require "twilio-ruby"
require "./TwilioEZ.rb"
$accountsid = "" #ACCOUNT SID HEERE
$authtoken = "" #AUTH TOKEN HERE
$phone = "" #SENDING PHONE NUMBER HERE
get("/") do
	erb :home
end
get("/thread/:t") do
	@thread = params["t"]
	if File.exist?("threads/#{params['t']}.thrd")
		erb :thread
	else
		redirect "/"
	end
	
end
post("/SEND") do
	to = params["thread"].gsub("-", "").gsub("(", "").gsub(")", "").gsub("+1", "").gsub(" ", "")
	if to.length == 5 || to.length == 6
		
	else
		to = "+1" + to
	end
	sendSMS(to, params["msg"])
	redirect "thread/#{to}#send"
end
get("/CT") do
	erb :new
end
get("/CC") do
	erb :CC
end
post("/CC1") do
	to = params["thread"].gsub("-", "").gsub("(", "").gsub(")", "").gsub("+1", "").gsub(" ", "")
	to = "+1" + to
	c = Hash[*File.read('threads/C').split(/[,\n]+/)]
	if c[to] == nil
		File.write("threads/C", "\n#{to},#{params["name"]}", mode: "a")
	else
		x = File.read("threads/C")
		x = x.gsub("\n#{to},#{c[to]}",  "\n#{to},#{params["name"]}")
		File.write("threads/C", x)
	end
	
	redirect "/"
end
get("/CC1/:thread/:name") do
	to = params["thread"].gsub("-", "").gsub("(", "").gsub(")", "").gsub("+1", "").gsub(" ", "")
	to = "+1" + to
	c = Hash[*File.read('threads/C').split(/[,\n]+/)]
	if c[to] == nil
		File.write("threads/C", "\n#{to},#{params["name"]}", mode: "a")
	else
		x = File.read("threads/C")
		x = x.gsub("\n#{to},#{c[to]}",  "\n#{to},#{params["name"]}")
		File.write("threads/C", x)
	end
	
	redirect "/"
end
get("/call/:n") do
	tml = "https://handler.twilio.com/twiml/EHaa77fc48367b411a5f2a2c76f825e83f"
	to = params["n"].to_s
	to = params["n"].gsub("-", "").gsub("(", "").gsub(")", "").gsub("+1", "").gsub(" ", "")
	to = "+1" + to
		account_sid = $accountsid
	auth_token = $authtoken
	@client = Twilio::REST::Client.new(account_sid, auth_token)

	call = @client.calls.create(
  	                     url: tml,
  	                     to: to,
   	                    from: $phone
   	                  )
	redirect "/thread/#{params["n"]}"
end
get("/RT/:t") do
	File.delete("threads/#{params["t"]}.thrd")
	File.write("threads/threads", File.read("threads/threads").gsub("\n" + params["t"], ""), mode: "w")
	File.write("threads/threads", File.read("threads/threads").gsub(params["t"], ""), mode: "w")
	if File.read("threads/threads") == ""
		File.delete("threads/threads")
	end
	redirect '/'
end
