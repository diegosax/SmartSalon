CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAIA5GE5E7QJQCGAAA",
    aws_secret_access_key: "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"
  }
  config.fog_directory = "instanap"
end