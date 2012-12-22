class Room < ActiveRecord::Base
  extend FriendlyId
  
  mount_uploader :picture, PictureUploader
  friendly_id :title, :use => [:slugged, :history]
  
  has_many :reviews, :dependent => :destroy
  has_many :reviewed_rooms, :through => :reviews, :source => :room
  
  belongs_to :user
  
  attr_accessible :description, :location, :title, :picture
  
  scope :most_recent, order("created_at DESC")

  def complete_name
    "#{title}, #{location}"
  end
  
  def self.search(query)
    if query.present?
      where(['location LIKE :query OR
        title LIKE :query OR
        description LIKE :query', :query => "%#{query}%"])
    else
      scoped
    end 
  end
end
