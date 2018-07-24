require 'rails_helper'

RSpec.feature "Visitor clicks on the cart link and one item is added to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do | n |
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "Visitor clicks on the cart link" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    save_screenshot
    find('.product', match: :first).find('.btn-primary').click
    cart = find(:xpath, "//a[@href='/cart']")
    expect(cart).to have_text 'My Cart (1)'
  end

end
