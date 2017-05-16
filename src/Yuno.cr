require "dotenv"
Dotenv.load(".env")
require "./Yuno/*"
require "ctx"
require "rethinkdb"

module Yuno
  Discord::LOGGER.level = Logger::WARN
  BOT = Ctx::Bot.new(token: ENV["TOKEN"],
                     client_id: 301679727540699136_u64)
  SELF = Ctx::Context.message_create { |m| m.author.id == 139395104455524352}
  BOT.run
end
