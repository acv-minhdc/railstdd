class Product < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  belongs_to :category
  before_save :strips_html_from_description

  def strips_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(self.description)
  end

  def lowcase_title
    self.title = title.downcase
  end

end
