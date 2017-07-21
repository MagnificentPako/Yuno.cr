module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    outp = IO::Memory.new(128)
    status = Process.run(command: "urn", args: ["--exec"], input: IO::Memory.new(arguments), output: outp)
    puts status
    BOT.edit_message(payload.channel_id, payload.id, outp.to_s)
  end
end
