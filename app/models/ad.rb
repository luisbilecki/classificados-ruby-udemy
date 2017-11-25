class Ad < ActiveRecord::Base
  #Enums
  enum status: [:active, :processing, :sold]

  #RatyRate
  ratyrate_rateable 'quality'

  #Associations
  belongs_to :category, counter_cache: true
  belongs_to :member
  has_many :comments

  #Constants
  QTT_PER_PAGE = 6

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
  scope :descending_order, -> ( page ) { page(page).per(QTT_PER_PAGE) }

  scope :ads_to_cm, -> (member) { where(member: member) }
  scope :by_category, -> (id, page) { where(category: id).page(page).per(QTT_PER_PAGE) }

  scope :search, -> (q, page) {where("lower(title) LIKE ?", "%#{q.downcase}%"
                    ).page(page).per(QTT_PER_PAGE)}
  scope :random, ->(quantity) { limit(quantity).order("RANDOM()") }

  def second
    self[1]
  end

  def third
    self[2]
  end

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
