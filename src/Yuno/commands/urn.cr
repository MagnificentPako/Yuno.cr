module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    proc = Process.run(command : String, input = IO::Memory.new(arguments.join " "), output = true)
    output = proc.output_gets_to_end
    status = proc.await
    puts status
    BOT.edit_message(payload.channel_id, payload.id, output)
  end
end
