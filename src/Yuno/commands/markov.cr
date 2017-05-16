require "json"

module Yuno
    chain = Chain.new

    File.open("/log.db","w") do |io|
        while line = io.gets
          chain << (line.from_json)["content"]
        end
    end

    BOT.message_create do |payload|
      File.open("/log.db","a") do |io|
        io << ({"content" => payload.content}).to_json << "\n"
      end
    end

    BOT.command("~~log", [SELF]) do |payload, args|
      BOT.create_message(payload.channel_id, chain.generate)
    end
end
