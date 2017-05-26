module Yuno
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
