require "rethinkdb"

module Yuno
    conn = RethinkDB.connect(db: "discord")
    chain = Chain.new
    RethinkDB.table("logs").run(conn).each do |e|
        chain << e["content"].to_s
    end

    BOT.command("~~log", [SELF]) do |payload, args|

    end
end