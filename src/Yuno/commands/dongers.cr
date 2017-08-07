require "json"

module Yuno
    wave = {} of String => Array(String)
    File.open("wave.json", "r") do |io|
        while line = io.gets
            wave = Hash(String, Array(String)).from_json(line)
        end
    end

    BOT.command("λwave", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, wave.values.sample.sample)
    end

    BOT.command("λlenny", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, LENNY.sample)
    end

    BOT.command("λflip", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, TABLE_FLIP.sample)
    end

    BOT.command("λunflip", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, TABLE_UNFLIP.sample)
    end
end
