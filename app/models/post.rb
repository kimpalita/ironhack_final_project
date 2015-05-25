class Post < ActiveRecord::Base
	belongs_to :user
	has_many :post_viewers, :class_name => "Viewing", :foreign_key => "viewed_post_id"
	has_many :keywords
	has_many :comments

	acts_as_votable

	validates :content, uniqueness: true
	validates :title, uniqueness: true

	def create_keywords
		response = AlchemyAPI.search(:keyword_extraction, text: self.content)
		#string does not always neccessarily yeild keywords
		if response != nil
			response.each { |item| self.keywords.create(name: item["text"]) }
		end
	end

	def extract_keywords
		self.keywords.map { |hash| hash.name }
	end

	def substitute_content
		content = self.content

		if self.keywords.any?
			keywords = self.keywords.map { |response_hash| response_hash.name }
	  		content.split(/(#{keywords.join('|')})/)
	     		.map {|s| keywords.include?(s) ? s : s.gsub(/./) {|c| (c==' ') ? c : '*'}}#.join
	    else
	    	content.gsub(/./) {|a| (a==' ') ? a : '*'}.split(" ")
	    end
	end

	def substitute_content_without_keywords(content)
		content.gsub(/./) {|a| (a==' ') ? a : '*'}
	end

	def split_keywords_in_content
		content = self.content
		keywords = self.extract_keywords
	  	content.split(/(#{keywords.join('|')})/)
	end

end