class Product < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validate :description_must_longer_than_title
  belongs_to :category, optional: true
  before_save :strips_html_from_description, :lowcase_title

  def strips_html_from_description
    self.description = ActionView::Base.full_sanitizer.sanitize(description)
  end

  def lowcase_title
    self.title.downcase!
  end

  def description_must_longer_than_title
    return if description.blank? || title.blank?
    errors.add(:description, 'can\'t be shorter than title') if description.length < title.length
  end
end
