class StringCalculator
	# Add accepts a string and returns the integer sum
	def add(numbers)
	# Step 0: handle nil/empty
	return 0 if numbers.nil? || numbers.strip.empty?

	numbers_body = numbers.dup
	# Default delimiter: comma or newline
	delimiter = /,|\n/

	# Support custom delimiter header: //DELIMITER\nREST
	if numbers_body.start_with?('//')
	md = numbers_body.match(/\A\/\/(.+)\n(.*)\z/m)
	if md
	custom_delim = md[1]
	numbers_body = md[2]
	# build a Regexp for splitting using the custom delimiter
	delimiter = Regexp.new(Regexp.escape(custom_delim))
	end
	end

	# Split using the chosen delimiter and parse integers
	tokens = numbers_body.split(delimiter)

	ints = tokens.map do |t|
	# treat empty tokens as 0 (defensive) — tokens shouldn't be empty for valid inputs
	t == '' ? 0 : Integer(t)
	rescue ArgumentError
	# If token is not an integer: raise more descriptive error or let it bubble; keep simple here
	raise ArgumentError, "invalid number: #{t.inspect}"
	end

	negatives = ints.select { |n| n < 0 }
	unless negatives.empty?
	# Required message: "negative numbers not allowed <n1,n2>"
	raise ArgumentError, "negative numbers not allowed #{negatives.join(',')}"
	end

	ints.sum
	end
end