class ApplicationContract < Dry::Validation::Contract
  config.messages.load_paths += Dir[Application.root.concat('/config/locales/**/dry_validation.*.yml')]
end
