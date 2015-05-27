module PostsHelper
	def obscured_post_content_to_html(post)
		content_to_html(post, post.substitute_content)
	end

	def post_content_to_html(post)
		content_to_html(post, post.split_keywords_in_content)
	end

	private
	def content_to_html(post, words)
		content = words.inject('') { |a, w| a + keyword_to_html(post, w) }
		"<p>#{content}</p>".html_safe
	end

	def keyword_to_html(post, word)
		if Keyword.recurring_keyword?(word)
			link_to(word, filter_post_path(:keyword => word), style: "font-weight:bold;")
		elsif post.extract_keywords.include?(word)
			"<b>#{word}</b>"
		else
			word
		end
	end
end
