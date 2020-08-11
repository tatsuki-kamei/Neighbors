class Question < ApplicationRecord
	has_many :answers, dependent: :delete_all, inverse_of: :question
	has_many :votes, dependent: :delete_all
	accepts_nested_attributes_for :answers, allow_destroy: true
	is_impressionable :counter_cache => true, :unique => true
end