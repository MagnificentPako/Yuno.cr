module Yuno
  BOT.command("~~urn", [SELF]) do |payload, args|
    proc = Process.run(command : String, args = nil, input = IO::Memory.new(args.join " "), output = true)
    output = proc.output_gets_to_end
    status = proc.await
    puts status
    BOT.edit_message(payload.channel_id, payload.id, output)
  end
end
