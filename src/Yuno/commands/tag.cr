require "nuummite"

module Yuno
    db = Nuummite.new "/yuno/storage", "tags.db"
    db.auto_garbage_collect_after_writes = 50

    BOT.command("λadd-tag", [SELF]) do |payload, args|
        tag, res = args.split 2
        db[tag] = res
        BOT.edit_message(payload.channel_id, payload.id, "Added tag!")
    end

    BOT.command("λdel-tag", [SELF]) do |payload, args|
        db.delete args
        BOT.edit_message(payload.channel_id, payload.id, "Removed tag!")
    end

    BOT.command("λtag", [SELF]) do |payload, args|
        BOT.edit_message(payload.channel_id, payload.id, db[args])
    end

    BOT.command("λtags", [SELF]) do |payload, args|
        output = "Available tags: "
        db.each do |k,v|
            output = output + k + ", "
        end
        output = output.rchop ", "
        BOT.edit_message(payload.channel_id, payload.id, output)
    end
end
