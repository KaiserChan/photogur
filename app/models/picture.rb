class Picture < ApplicationRecord

validates :artist, presence: true
validates :title, length: { in: 3..20 }
validates :url, presence: true, uniqueness: true


  def self.newest_first
    Picture.order("created_at DESC")
  end

  def self.most_recent_five
    Picture.newest_first.limit(5)
  end

  def self.created_before(time)
    Picture.where("created_at < ?", time)
  end

  def self.pictures_created_in_year(year)
    Picture.where("created_at = ?", year)
  end

  def self.created_one_month_ago(time)
    Picture.where("created_at <?", time.current - 1.month)
  end

end
