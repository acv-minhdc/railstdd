require 'rails_helper'

describe 'User can CRUD products', type: :feature do
  it 'can create a product' do
    visit root_path
    expect(page).to have_link 'Create a product'
    click_on 'Create a product'
    expect(page).to have_content 'Create Product'
    fill_in 'Title', with: 'jQuery book'
    fill_in 'Description', with: 'JQuery for beginner to advance'
    fill_in 'Price', with: 18
    click_on 'Submit'
    expect(page).to have_content 'jquery book'
  end

  let!(:products) { create_list(:product, 2) }

  it 'edit product' do
    visit edit_product_path(products.first.id)
    fill_in 'Title', with: 'Changed Title'
    fill_in 'Description', with: 'Changed Description'
    click_on 'Submit'
    expect(page).to have_content 'changed title'
  end

  it 'delete a product' do
    visit products_path
    expect{
      # click_on 'Delete'
      page.first('.icon-delete').click
    }.to change {Product.count}.by(-1)
  end

  it 'listing products' do
    visit products_path
    expect(page).to have_content 'ruby'
    expect(page).to have_content 'Ruby Learning'
  end
end
