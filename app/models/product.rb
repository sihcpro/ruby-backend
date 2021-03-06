class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders]

  validates :name, presence: true
  validates :price, :quantity_stock, :description, :detail, presence: true
  validates :quantity_stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :unit
  belongs_to :shop
  belongs_to :category
  has_many :carts
  has_many :product_images
  has_many :orders
  has_many :user_orders, through: :orders
  has_many :users, through: :user_orders
  has_one :product_image
  has_one :cart

  def shop_name
    Shop.find(shop_id).shop_name
  end

  def slug_candidates
    %i[name shop_name id]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
