module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    proc = Process.run(command: "urn", args: ["--exec"], input: IO::Memory.new(arguments), output: nil)
    output = proc.output.gets_to_end
    status = proc.await
    puts status
    BOT.edit_message(payload.channel_id, payload.id, output)
  end
end
