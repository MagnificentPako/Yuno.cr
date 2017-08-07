require "json"

module Yuno
    chain = Chain.new
    exists = File.exists? "log.db"

    if exists
        File.open("log.db", "r") do |io|
            while line = io.gets
                chain << (Hash(String, String).from_json(line))["content"]
            end
        end
    end

    BOT.on_message_create do |payload|
        if exists
            File.open("log.db", "a") do |io|
                io << ({"content" => payload.content}).to_json << "\n"
            end
        end
    end

    BOT.command("λlog", [SELF]) do |payload, args|
        if exists
            begin
                chain.generate
            rescue ex : Exception
                ex.inspect_with_backtrace
            end
            BOT.edit_message(payload.channel_id, payload.id, chain.generate_n)
        end
    end
end
