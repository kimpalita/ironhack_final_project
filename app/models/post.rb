class Post < ActiveRecord::Base
	belongs_to :user
	has_many :post_viewers, :class_name => "Viewing", :foreign_key => "viewed_post_id"
	has_many :keywords, dependent: :destroy
	has_many :comments, dependent: :destroy

	acts_as_votable

	validates :content, presence: true, uniqueness: true, length: {minimum: 20, maximum: 600}
	validate :detectable_language
	validates :title, presence: true, uniqueness: true, length: {minimum: 3, maximum: 48}

	#Scopes for filtering and sorting
	scope :author, -> (user_id) { where user_id: user_id }
	scope :keyword, -> (keyword) { joins(:keywords).where(keywords: {name: keyword}) }
	scope :already_viewed, -> (user_id) { joins(:post_viewers).where(viewings: {viewer_id: user_id}) }
	scope :not_yet_viewed, -> (user_id) { not_yet_viewed(user_id) }
	scope :most_likes, -> { order(:cached_votes_up => :desc) }
	scope :most_views, -> {
		select("posts.id, posts.user_id, posts.content, posts.created_at, posts.title, count(viewings.id) AS views_count").
		joins(:post_viewers).
		group("posts.id").
		order("views_count DESC")
		}
	
	def self.not_yet_viewed(user_id)
		not_mine = where('user_id!=?', user_id)
		already_viewed = joins(:post_viewers).where(viewings: {viewer_id: user_id})
		not_mine - already_viewed
	end

	def detectable_language
		results = AlchemyAPI.search(:language_detection, text: content)
		unless permitted_languages.include?(results["language"])
			errors.add(:content, "unable to detect language or content is not a permitted language.")
		end
	end

	def create_keywords
		response = AlchemyAPI.search(:keyword_extraction, text: self.content)
		#string does not always neccessarily yeild keywords
		if response != nil
			response.each { |item| self.keywords.create(name: item["text"]) }
		end
	end

	private
	def permitted_languages
		["english", "spanish", "french", "german", "italian"]
	end

end