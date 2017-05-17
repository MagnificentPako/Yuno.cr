require "json"

module Yuno
  chain = Chain.new

  File.open("log.db", "r") do |io|
    while line = io.gets
      chain << (Hash(String, String).from_json(line))["content"]
    end
  end

  BOT.on_message_create do |payload|
    File.open("log.db", "a") do |io|
      io << ({"content" => payload.content}).to_json << "\n"
    end
  end

  BOT.command("~~log", [SELF]) do |payload, args|
    begin
      chain.generate
    rescue ex : Exception
      ex.inspect_with_backtrace
    end
    BOT.create_message(payload.channel_id, chain.generate)
  end
end
