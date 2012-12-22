require 'test_helper'

class ArtistsHelperTest < ActionView::TestCase
	def test_on_ampersand_too_short
		assert_equal split_on_and(["You & Me"]), ["You & Me"]
	end

	def test_on_ampersand_too_short
		assert_equal split_on_and(["Yourself and Myself"]), ["Yourself", "& Myself"]
	end

	def test_on_and_too_short
		assert_equal split_on_and(["You and Me"]), ["You and Me"]
	end

	def test_on_and_split
		assert_equal  split_on_and(["Yourself and Myself"]), ["Yourself", "and Myself"]
	end

	def test_on_featuring
		assert_equal( split_on_featuring(["The World Ain't Over Til We Say It's Over Apocalypse After Party Featuring Slobberbone, Old Warhorse, Cornhole And The Make Believers"]), ["The World Ain't Over Til We Say It's Over Apocalypse After Party", "Featuring Slobberbone, Old Warhorse, Cornhole And The Make Believers"] )
	end
end
