require "nuummite"

module Yuno
    db = Nuummite.new "storage", "tags.db"
    db.auto_garbage_collect_after_writes = 50

    BOT.command("~~add-tag", [SELF]) do |payload, args|
        tag, res = args.split 2
        db[tag] = res
        BOT.edit_message(payload.channel_id, payload.id, "Added tag!")
    end

    BOT.command("~~del-tag", [SELF]) do |payload, args|
        db.delete args
        BOT.edit_message(payload.channel_id, payload.id, "Removed tag!")
    end

    BOT.command("~~tag", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, db[args])
    end
end
