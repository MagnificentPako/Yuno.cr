module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    io = IO::Memory.new
    status = Process.run(command: "urn --exec | stripcolorcodes", shell: true, input: IO::Memory.new(arguments), output: io)
    em = Discord::Embed.new(
        title: "Urn🔥",
        colour: 5025616,
        fields: [
            Discord::EmbedField.new(
                name: "Input:",
                value: "```lisp\n#{arguments}\n```"
            ),
            Discord::EmbedField.new(
                name: "Output:",
                value: "```lisp\n#{io.to_s}\n```"
            )
        ]
    )
    BOT.edit_message(payload.channel_id, payload.id, "", em)
  end
end
