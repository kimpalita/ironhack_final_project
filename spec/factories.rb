FactoryGirl.define do
  factory :first_user, class: User do
    name "Marcus"
    email "marcus@mail.com"
    password "12345678"
    password_confirmation "12345678"
  end

  factory :first_post, class: Post do
    title "My Post"
    content "Man walked into the bar and said ouch."
  end

  # This will use the User class (Admin would have been guessed)
end