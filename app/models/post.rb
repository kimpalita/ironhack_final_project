class Post < ActiveRecord::Base
	belongs_to :user
	has_many :post_viewers, :class_name => "Viewing", :foreign_key => "viewed_post_id"
	has_many :keywords

	validates :content, uniqueness: true

	def create_keywords
		response = AlchemyAPI.search(:keyword_extraction, text: self.content)
		response.each { |item| self.keywords.create(name: item["text"]) }
	end

	def extract_keywords
		keyword_array = self.keywords.map { |hash| hash.name }
		keyword_array
	end

	def substitute_content(str, keywords)
	  	str.split(/(#{keywords.join('|')})/)
	     .map {|s| keywords.include?(s) ? s : s.gsub(/./) {|c| (c==' ') ? c : '*'}}
	     #.join
	end

	def split_keywords_in_content(str, keywords)
	  	str.split(/(#{keywords.join('|')})/)
	end

end