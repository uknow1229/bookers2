class Book < ApplicationRecord
  belongs_to :user

  has_one_attached :profile_image

  validates :title, presence: true
  validates :body, length: { maximum: 200 }, presence: true
  validates :category, presence: true

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :post_comments, dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } 
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } 
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 
  
  scope :created_2days, -> { where(created_at: 2.days.ago.all_day) } 
  scope :created_3days, -> { where(created_at: 3.days.ago.all_day) } 
  scope :created_4days, -> { where(created_at: 4.days.ago.all_day) } 
  scope :created_5days, -> { where(created_at: 5.days.ago.all_day) } 
  scope :created_6days, -> { where(created_at: 6.days.ago.all_day) } 

  # def get_profile_image(width, height)
  # unless profile_image.attached?
  #   file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #   profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  # end
  # profile_image.variant(resize_to_limit: [width, height]).processed
  # end
end
