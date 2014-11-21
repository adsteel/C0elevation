require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	:domain               => "www.coelevation.com",
	:user_name            => "coelevation",
	:password             => "210w2ndst",
	:authentication       => "plain",
	:enable_starttls_auto => true
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?