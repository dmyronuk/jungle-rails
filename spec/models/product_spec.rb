require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "Validations" do

    before :each do
      @category = Category.new(name: "Apparel")
      @product = Product.new(name: "Hipster Hat", description:"What a great hat", image:"images/hat.png", price_cents:1000, quantity:10, category:@category)
    end

    it "is valid when all required fields present" do
      @product.save
      expect(@product.errors.full_messages.empty?).to be true
    end

    #it validates :name, presence: true
    it "is not valid without a name" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it "is not valid without a quantity" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it "is not valid without a price" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Price cents is not a number")
      expect(@product.errors.full_messages[1]).to eq("Price is not a number")
      expect(@product.errors.full_messages[2]).to eq("Price can't be blank")
    end

    it "is not valid without a category" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages[0]).to eq("Category can't be blank")
    end
  end
end

=begin
  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "price_cents"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=end