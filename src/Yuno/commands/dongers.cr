module Yuno
  BOT.command("~~lenny", [SELF]) do |payload, args|
    BOT.create_message(payload.channel_id, LENNY.sample)
  end

  BOT.command("~~flip", [SELF]) do |payload, args|
    BOT.create_message(payload.channel_id, TABLE_FLIP.sample)
  end

  BOT.command("~~unlfip", [SELF]) do |payload, args|
    BOT.create_message(payload.channel_id, TABLE_UNFLIP.sample)
  end
end
