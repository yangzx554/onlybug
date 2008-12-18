# == Schema Information
# Schema version: 20080620142850
#
# Table name: users
#
#  id                   :integer(11)   not null, primary key
#  name                 :string(255)   
#  email                :string(255)   
#  password_hash        :string(255)   
#  login_key            :string(255)   
#  login_key_expires_at :datetime      
#  last_seen_at         :datetime      
#  created_at           :datetime      
#  updated_at           :datetime      
#  salt                 :string(255)   
#  photo_id             :integer(11)   
#

# == Schema Information
# Schema version: 20080502120104
#
# Table name: users
#
#  id                   :integer(11)   not null, primary key
#  name                 :string(255)   
#  email                :string(255)   
#  password_hash        :string(255)   
#  login_key            :string(255)   
#  login_key_expires_at :datetime      
#  last_seen_at         :datetime      
#  created_at           :datetime      
#  updated_at           :datetime      
#  salt                 :string(255)   
#  photo_id             :integer(11)   
#


require 'digest/sha1'
require 'uuidtools'
class User < ActiveRecord::Base
  acts_as_cached
  after_save :expire_cache
  attr_accessor :password
  validates_confirmation_of :password, :if => :password_required?
  validates_presence_of :name
  validates_presence_of :password, :if => :password_required?
  validates_presence_of :password_confirmation, :if => :password_required?
  validates_length_of :password_confirmation, :within => 4..40 ,:if => :password_required?
  validates_length_of :password, :within => 4..40, :if => :password_required?
  validates_length_of :name, :within => 2..40
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^([^@\s]{1}+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create, :must=>"Invalid email address."
  before_save :encrypt_password
  has_many :versions
  has_many :project_users ,:dependent => :destroy
  has_many :projects ,:through=>:projects_users
  has_many :myProjects,:class_name =>"Project"
  has_many :myTickets , :class_name => "Ticket"
  has_many :assigned_tickets ,:class_name => "Ticket",:foreign_key => 'assigned_id'
  belongs_to :photo
  has_many :events
  def self.authenticate(email,password)
    u = find_by_email email
    u && u.authenticated?(password) ? u : nil
  end
  def authenticated?(password)
    password_hash == encrypt(password)
  end
  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def remember_me
    self.login_key_expires_at = 1.years.from_now
    self.login_key =  UUID.random_create.to_s + '-' + UUID.random_create.to_s if self.login_token.nil?
    save false
  end
  def login_token
    return if self.login_key
  end
  def login_token?
    login_key_expires_at && login_key_expires_at > Time.now.utc
  end
  private 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{name}--") if
    new_record? || @forgot
    self.password_hash = encrypt(password)
  end
  
  def password_required?
    encrypt_password.blank? || !password.blank?
  end
  
end
