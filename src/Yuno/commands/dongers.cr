require "json"

module Yuno

  wave = {} of String => Array(String)
  File.open("wave.json", "r") do |io|
    while line = io.gets
      wave = Hash(String, Array(String)).from_json(line) 
    end
  end
     
  BOT.command("~~wave", [SELF]) do |payload, args|
    BOT.edit_message(payload.channel_id, payload.id, wave.values.sample.sample)
  end

  BOT.command("~~lenny", [SELF]) do |payload, args|
    BOT.edit_message(payload.channel_id, payload.id, LENNY.sample)
  end

  BOT.command("~~flip", [SELF]) do |payload, args|
    BOT.edit_message(payload.channel_id, payload.id, TABLE_FLIP.sample)
  end

  BOT.command("~~unflip", [SELF]) do |payload, args|
    BOT.edit_message(payload.channel_id, payload.id, TABLE_UNFLIP.sample)
  end
end
