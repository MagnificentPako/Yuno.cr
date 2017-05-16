module Yuno
    BOT.command("~~ping", [SELF]) do |payload, args|
        BOT.create_message(payload.channel_id, "Pong!")
    end
end