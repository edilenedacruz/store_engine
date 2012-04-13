require 'spec_helper'

describe "Products Show Requests" do
  context "product" do
    let!(:product) {Fabricate(:product)}
    let!(:categories) do
      10.times {Fabricate(:category)}
    end
    let!(:product_categories) do
      [p_c_one = Fabricate(:product_category, :product_id => 1, :category_id => 1),
       p_c_two = Fabricate(:product_category, :product_id => 1, :category_id => 2),
       p_c_three = Fabricate(:product_category, :product_id => 1, :category_id => 3),
      ]
    end

    before(:each) do
      visit "/products/#{product.id}"
    end

    it "lists the categories for the product" do
      product_categories.each do |product_category|
        category = Category.find_by_id(product_category.category_id)
        page.should have_link(category.name, :href => category_path(category))
      end
    end

    it "displays product info" do
      page.should have_content(product.title)
      page.should have_content(product.description)
      page.should have_content(product.price) 
    end

    it "shows a link to all products" do
      within("ul#options") do
        page.should have_link('All Products', href: products_path)
      end
    end

    it "has a one-click checkout link" do
      page.should have_link("Instant Checkout")
    end
  end
end
