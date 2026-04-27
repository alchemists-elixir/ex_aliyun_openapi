import Config

secret_config = "#{Mix.env()}.secret.exs"

if File.exists?(secret_config) do
  import_config secret_config
else
  config :ex_aliyun_openapi,
    cps: [access_key_id: "", access_key_secret: ""],
    sts: [access_key_id: "", access_key_secret: ""],
    sms: [access_key_id: "", access_key_secret: ""],
    global_sms: [access_key_id: "", access_key_secret: ""],
    afs: [access_key_id: "", access_key_secret: ""],
    codeup: [access_key_id: "", access_key_secret: ""],
    geoip: [access_key_id: "", access_key_secret: ""]
end
