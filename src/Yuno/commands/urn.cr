module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    io = IO::Memory.new
    status = Process.run(command: "urn", args: ["--exec"], input: IO::Memory.new(arguments), output: io)
    puts status.exit_status
    BOT.edit_message(payload.channel_id, payload.id, io.to_s)
  end
end
