module UsersHelper
	# Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user, options={})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)	
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		if options.include?(:size)
			image_tag(gravatar_url, alt: user.name, size: "#{options[:size]}x#{options[:size]}", class: "gravatar")
		else
			image_tag(gravatar_url, alt: user.name, class: "gravatar")
		end
	end
end
