namespace :penny do
  desc "This task detects spam messages and delete them"
  task :spam => :environment do
  	#DEFINE THE FUNCTION HERE (RAKE TASKS TO BE CALLED FROM SHELL OR USING CONSOLE),
  	#FOR EXAMPLE:
  	#Post.where(verified: false).each do |post|
  	#	MyLib.is_spam(post.content) ? post.set_as_spam! : post.set_as_verified!
  	#	post.save
  	#end
  end
end
