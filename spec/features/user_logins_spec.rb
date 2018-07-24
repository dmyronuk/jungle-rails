require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

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

    User.create!({
      first_name: 'frank',
      last_name: 'tank',
      email: 'frank@tank.com',
      password: 'password',
      password_confirmation: 'password'
    })
  end


  scenario "They see all products" do
    # ACT
    visit login_path

    fill_in 'email', with: 'frank@tank.com'
    fill_in 'password', with: 'password'
    find('input[type=submit]').click
    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_css 'article.product', count: 10
  end

end