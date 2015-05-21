class Keyword < ActiveRecord::Base
	belongs_to :post

	def self.recurring_keyword?(string)
		#class method of Keyword"
		Keyword.where(name: string).count > 1
	end
end
