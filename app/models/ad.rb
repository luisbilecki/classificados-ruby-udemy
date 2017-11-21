class Ad < ActiveRecord::Base
  #Associations
  belongs_to :category, counter_cache: true
  belongs_to :member

  #Callbacks
  before_save :md_to_html

  #validates
  validates :title, :description_short, :description_md, :category, :picture, presence: true
  validates :finish_date, presence: true
  validates :price , numericality: { greater_than: 0 }

  # paperclip
  has_attached_file :picture, styles: { large:"800x300#", medium: "320x150#", thumb: "100x100>"},
                                   default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  # gem money-rails
  monetize :price_cents

  # Scopes
  scope :descending_order, -> (qtd = 10) { limit(qtd).order(created_at: :desc) }
  scope :ads_to_cm, -> (member) { where(member: member) }
  scope :by_category, -> (id) { where(category: id)}

  private

    def md_to_html
      options = {
          filter_html: true,
          link_attributes: {
            rel: "nofollow",
            target: "_blank"
          }
      }

      extensions = {
        space_after_headers: true,
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      markdown = Redcarpet::Markdown.new(renderer, extensions)

      self.description = markdown.render(self.description_md)
    end


end
