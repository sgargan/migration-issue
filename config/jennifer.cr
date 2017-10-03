require "colorize"
require "uri"
require "yaml"

DATABASE_CONFIG = "./config/database.yml"

Jennifer::Config.configure do |conf|
  adapter = {% if env("DB") == "postgres" || env("DB") == nil %} "postgres" {% else %} "mysql" {% end %}
  db_uri = YAML.parse(File.read(DATABASE_CONFIG))[adapter]["database"]
  puts "parsing DB uri #{db_uri}"
  uri = URI.parse(db_uri.to_s)

  conf.adapter = adapter
  conf.db = uri.path.to_s.lchop
  conf.user = uri.user.to_s if uri.user
  conf.password = ""
  # if uri.port
  #   conf.host = "#{uri.host}:#{uri.port}"
  # elsif uri.host
    conf.host = uri.host.to_s
  # end

  conf.logger = Logger.new(STDOUT)

  conf.logger.formatter = Logger::Formatter.new do |severity, datetime, progname, message, io|
    io << datetime.colorize(:cyan) << ": " << message.gsub("\n", " ").colorize(:light_magenta)
  end
  conf.logger.level = Logger::DEBUG
end
