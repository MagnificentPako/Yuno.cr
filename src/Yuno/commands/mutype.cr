module Yuno
  BOT.command("λmutype", [SELF]) do |payload, arguments|
    io = IO::Memory.new
    status = Process.run(command: "mueval", args: ["-iTe", arguments], input: IO::Memory.new(arguments), output: io)
    em = Discord::Embed.new(
        title: "μtypes🌈",
        colour: status.exit_status == 0 ? 5025616_u32 : 16007990_u32,
        fields: [
            Discord::EmbedField.new(
                name: "Input:",
                value: "```haskell\n#{arguments}\n```"
            ),
            Discord::EmbedField.new(
                name: "Output:",
                value: "```haskell\n#{io.to_s}\n```"
            )
        ]
    )
    BOT.edit_message(payload.channel_id, payload.id, "", embed: em)
  end
end
