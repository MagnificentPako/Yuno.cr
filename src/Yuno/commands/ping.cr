module Yuno
    BOT.command("λping", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, "Pong!")
    end
end
