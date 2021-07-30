require "twilio-ruby"
require "sinatra"
def GT(message)
	return "<Response><Message>#{message}</Message></Response>"
end
def logMSG(phone, body, mu0)

if File.exist?("./threads/" + phone + ".thrd")
	File.write("./threads/" + phone + ".thrd", "\n#{Time.now.inspect}█RECEIVE█#{body.gsub("\n", "\\n")}█#{mu0}", mode: "a")
else
	File.write("./threads/" + phone + ".thrd", "#{Time.now.inspect}█RECEIVE█#{body.gsub("\n", "\\n")}█#{mu0}", mode: "w")
	if File.exist?("./threads/threads")
		File.write("./threads/threads", "\n" + phone, mode: "a")
	else
		File.write("./threads/threads", phone, mode: "w")
	end
end

return nil
end
post("/im") do
puts params
logMSG(params["From"], params["Body"], params["MediaUrl0"])

	# GT("Hi, #{params["From"]}\nYour message,\n\"#{params["Body"]}\"\nwas received.")
end