module Yuno
  BOT.command("~~urn", [SELF]) do |payload, arguments|
    io = IO::Memory.new
    status = Process.run(command: "urn -i /yuno/urn_std --exec | stripcolorcodes", shell: true, input: IO::Memory.new("(import yuno ())\n" + arguments), output: io)
    em = Discord::Embed.new(
        title: "Urn🔥",
        colour: 5025616_u32,
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
    BOT.edit_message(payload.channel_id, payload.id, "", embed: em)
  end
  `rm -rf /yuno/urn_std`
  'git clone https://github.com/MagnificentPako/YunoUrnLibs.git /yuno/urn_std'
  BOT.command("~~update-urn", [SELF]) do |payload, arguments|
    em = Discord::Embed.new(
        title: "Urn🔥",
        colour: 5025616_u32,
        content: "Update finished!"
    )
    BOT.edit_message(payload.channel_id, payload.id, "", embed: emb)
  end
end
