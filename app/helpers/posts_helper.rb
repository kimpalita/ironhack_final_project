module PostsHelper
	include Rewards::Spend

	def render_penny_alert(user)
		render ("shared/penny_alert") if user.total_points < VIEWING_POST
	end

	def obscured_post_content_to_html(post)
		content_to_html(post, obscure_non_keywords(post))
	end

	def post_content_to_html(post)
		content_to_html(post, split_keywords_in_content(post))
	end

	def render_post_list_item(post)
		if Post.already_viewed(current_user.id).include? post
			return render("posts/already_viewed", post: post)
		elsif post.user_id == current_user.id
			return render("posts/post_by_user", post: post)
		else
			return render("posts/standard_post", post: post)
		end
	end

	def render_post_status_for(post)
	end

	def render_view_button_for(post)
		if @viewed_posts.include?(post) || current_user.id == post.user_id
			button_to(user_post_path(current_user.id, post.id), method: :get, class: "view-content-btn btn btn-default btn-lg btn-block") do
				"<i class='fa fa-circle'></i>".html_safe
			end
		else
			button_to(create_view_path(post.id), class: "btn btn-primary btn-lg btn-block", disabled: current_user.total_points < VIEWING_POST ? true : false) do
				"<i class='fa fa-circle'></i>".html_safe
			end
		end
	end

	def render_post_tags(post)
		if @viewed_posts.include?(post)
		end
		if post.user_id == current_user.id
		end
	end

	private
	def content_to_html(post, words)
		content = words.inject('') { |a, w| a + keyword_to_html(post, w) }
		"<p>#{content}</p>".html_safe
	end

	def keyword_to_html(post, word)
		if Keyword.recurring_keyword?(word)
			link_to(word, filter_post_path(:keyword => word), style: "font-weight:bold;")
		elsif extract_keywords(post).include?(word)
			"<b>#{word}</b>"
		else
			word
		end
	end

	def extract_keywords(post)
		post.keywords.map { |keyword| keyword.name }
	end

	def obscure_non_keywords(post)
		if post.keywords.any?
			keywords = post.keywords.map { |response_hash| response_hash.name }
	  		#post.content.split(/(#{keywords.join('|')})/).map do |s|
	  		split_keywords_in_content(post).map do |word| 
	  			#keywords.include?(s) ? s : s.gsub(/./) { |c| (c==' ') ? c : "\u25A0".encode('utf-8')}
	  			keywords.include?(word) ? word : substitute_characters(word)
	  		end
	    else
	    	#post.content.gsub(/./) {|a| (a==' ') ? a : "\u25A0".encode('utf-8')}.split(" ")
	    	substitute_characters(post.content).split(" ")
	    end
	end

	def substitute_characters(characters)
		characters.gsub(/./) {|char| (char==' ') ? char : "\u25A0".encode('utf-8')}
	end

	def split_keywords_in_content(post)
	  	post.content.split(/(#{extract_keywords(post).join('|')})/) || []
	end

end
