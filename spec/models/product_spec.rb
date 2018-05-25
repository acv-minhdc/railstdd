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
    it "Strips HTML from description" do
      c = Category.create!
      p = Product.create! title: 'Book', description: '<h1>Hello World</h1>', price: 10, category: c
      expect(p.description).to eq 'Hello World'
    end

    it "Make title lowcase" do
      p = create(:product, title: 'HeLlO', category: create(:category))
      p.lowcase_title
      expect(p.title).to eq 'hello'
    end
  end

end
