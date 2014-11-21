if Rails.env.development?
    ENV['AWS_BUCKET'] = 'ce_bucket_1'
    ENV['AWS_ACCESS_KEY_ID'] = 'XXX'
    ENV['AWS_SECRET_ACCESS_KEY'] = 'XXX/XXX'
end