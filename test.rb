def string_message(string)
	if string.empty?
		"It's an empty string!"
	else 
		"The string is nonempty."
	end
end

class Word < String
	def palindrome?
		self == self.reverse
	end
end

w = Word.new("ba")
puts w.palindrome?
