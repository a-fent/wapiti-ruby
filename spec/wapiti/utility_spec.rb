require 'spec_helper'

describe 'Utility Methods' do
	
	let(:pattern) { File.expand_path('../../fixtures/chpattern.txt', __FILE__) }
	let(:input) { File.expand_path('../../fixtures/chtrain.txt', __FILE__) }
	
	describe 'train' do
		it 'creates a new model according to the parameters given in the options hash' do
			# Wapiti.train(input, :pattern => pattern).should be_valid_model
		end

		it 'creates a new model according to the options set in the block' do
			# Wapiti.train { |c|
			# 	c.pattern = pattern
			# 	c.input = input
			# }.should be_valid_model
		end

	end
	
end