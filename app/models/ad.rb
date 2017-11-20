class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member

  # paperclip
  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>" },
                                   default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents

  # Scopes
  scope :descending_order, -> (qtd = 10) { limit(qtd).order(created_at: :desc) }
  scope :ads_to_cm, -> (member) { where(member: member) }


end
