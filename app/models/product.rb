class Product < ApplicationRecord
  has_rich_text :description
  has_many_attached :images

  scope :sorted, ->(option){
    case option
    when "low_to_high"
      order(price: :asc)
    when "high_to_low"
      order(price: :desc)
    when "newest_to_oldest"
      order(created_at: :desc)
    when "oldest_to_newest"
      order(created_at: :asc)
    end
  }

end

