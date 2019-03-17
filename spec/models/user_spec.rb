require 'rails_helper'

RSpec.describe User, type: :model do

  subject (:user) { User.new(email: "hi@app.com", password: "hiandgood") }

  describe 'validations' do
    it { should validate_presence_of(:email)}
    it { should validate_length_of(:password).is_at_least(6) }
    it do 
      should validate_presence_of(:password_digest).
      with_message("Password can\'t be blank.")
    end
  end

  describe '#is_password?' do 
    it 'should return false if password is different from the saved password_digest' do 
      password_digest = BCrypt::Password.create("okandbye")
      res = BCrypt::Password.new(password_digest).is_password?("okandhello")
      expect(res).to be false
    end

    it 'should return true if password is same as saved password_digest' do 
      password_digest = BCrypt::Password.create("okandbye")
      res = BCrypt::Password.new(password_digest).is_password?("okandbye")
      expect(res).to be true
    end
  end

  describe '::reset_session_token!' do
    it 'should generate a new session token' do 
      new_session_token = user.class.generate_session_token
      expect(new_session_token).not_to eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do 
    before { user.save! }
    it 'should return nil if can\'t find the email in database' do 
      expect(User.find_by_credentials('jack1', 'qwert')).to eq(nil)
    end

    it 'should return the user if it credentials match' do 
      expect(User.find_by_credentials("hi@app.com", "hiandgood")).to eq(user)
    end
  end
end
