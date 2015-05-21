require 'rails_helper'

describe 'Alchemy API outputs' do
	before(:each) do
		@content = "A man stopped at his favorite watering hole after a hard days work to relax.
					He noticed a man next to him ordered a shot and a beer. The man drank the shot,
					chased it with the beer and then looked into his shirt pocket. This continued
					several times before the man's curiosity got the best of him. He leaned over to
					the guy and said, \"Excuse me, I couldn't help but notice your little ritual,
					why in the world do you look into your shirt pocket every time you drink your
					shot & beer\"? The man replied, \"There's a picture of my wife in there, and
					when she starts lookin\' good, I\'m headin\' home\"!"
	end

	context 'a json response' do
		#results = JSON.parse(response, {:symbolize_names => true})
		it 'and gets an array' do
				response = AlchemyAPI.search(:keyword_extraction, text: @content)
				expect(response).to be_kind_of Array
		end
	end

end