require 'rails_helper'

RSpec.describe Product, type: :model do
  context "Validation" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
  end

  context "Association" do
    it { should belong_to(:category) }
  end

  context "Custom Validation" do
    let!(:product) { create(:product, description: '<h1>Hello World</h1>') }
    let!(:new_product) { build(:product, description: 'Ru') }

    it "Strips HTML from description" do
      expect(product.description).to eq 'Hello World'
    end

    it "Make title lowcase" do
      expect(product.title).to eq 'ruby'
    end

    it "Description must longer than title" do
      new_product.validate
      expect(new_product.errors.messages).to include(description: ['can\'t be shorter than title'])
    end
  end

end
