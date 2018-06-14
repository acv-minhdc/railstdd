require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:products) { create_list(:product, 2) }

  describe '#index' do
    it 'gets a list of products' do
      # products = []
      # products << create(:product, title: '123', description: '123')
      # products << create(:product, title: '123', description: '123')

      get :index
      expect(assigns(:products).size).to eq products.size
      expect(response).to render_template :index
    end
  end

  describe '#show' do
    it 'show a product' do
      get :show, params: { id: products.first.id }
      expect(assigns(:product)).to eq products.first
      expect(response).to render_template :show
    end
  end
  describe '#new' do
    it 'render new' do
      get :new
      expect(response).to render_template :new
      expect(assigns(:product)).to be_a Product
    end
  end
  describe '#create' do
    it 'success' do
      post :create, params: { product: { title: 'test p', description: 'description test', price: 10 } }
      expect(assigns(:product).title).to eq 'test p'
      expect(assigns(:product).description).to eq 'description test'
      expect(assigns(:product).id).to_not eq nil
      expect{ create(:product) }.to change { Product.count }.by(1)
    end
    it 'failure' do
      expect{ create(:product, price: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  describe '#edit' do
    it 'sucess' do
      get :edit, params: { id: products.first.id }
      expect(response).to render_template :edit
      expect(assigns(:product)).to eq products.first
    end
  end
  describe '#update' do
    it 'success' do
      p = products.first
      put :update, params: {id: products.first.id, product: { title: 'Changed title', description: 'Changed description' } }
      expect(assigns(:product).equal? p).to eq false
      expect(assigns(:product).price).to eq p.price
    end

    # it 'failure' do
    #   p = products.first
    #   put :update, params: {id: products.first.id, product: { title: 'Changed title', description: '' } }
    #   expect(assigns(:product).equal? p).to eq true
    #   expect(assigns(:product).title).to eq p.title
    #   expect(response).to render_template :new
    # end

  end
  describe '#destroy' do
    it 'success' do
      expect{products.first.destroy}.to change { Product.count }.by(-1)
      delete :destroy, params: { id: products.second.id }
      expect {Product.find(products.second.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
