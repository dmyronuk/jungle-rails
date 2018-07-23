require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do

    # before :each do

    # end

    it "should be valid when all fields are present" do
      @user = User.new(first_name: "Billy", last_name: "Jean", email:"not_lover@one.com", password:"zzzzzzz", password_confirmation:"zzzzzzz")
      @user.save
      expect(@user.errors.full_messages.empty?).to be true
    end

    it "should be invalid when first_name is not present" do
      @user = User.new(last_name: "Jean", email:"not_lover@one.com", password:"zzzzzzz", password_confirmation:"zzzzzzz")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("First name can't be blank")
    end

    it "should be invalid when last_name is not present" do
      @user = User.new(first_name: "Billy", email:"not_lover@one.com", password:"zzzzzzz", password_confirmation:"zzzzzzz")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("Last name can't be blank")
    end

    it "should be invalid when email is not present" do
       @user = User.new(first_name: "Billy", last_name: "Jean", password:"zzzzzzz", password_confirmation:"zzzzzzz")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("Email can't be blank")
    end

    it "should be invalid when password does not match password_confirmation" do
      @user = User.new(first_name: "Billy", last_name: "Jean", email:"not_lover@one.com", password:"password1", password_confirmation:"password2")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("Password confirmation doesn't match Password")
    end

    it "should be invalid when password is nil" do
      @user = User.new(first_name: "Billy", last_name: "Jean", email:"not_lover@one.com", password:nil, password_confirmation:"password2")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("Password can't be blank")
    end

    it "should be invalid when another email exists in the database" do
      @userA = User.new(first_name: "Billy", last_name: "Jean", email:"not_lover@one.com", password:"password1", password_confirmation:"password1")
      @userB = User.new(first_name: "Michael", last_name: "Jackson", email:"NOT_lover@one.com", password:"password2", password_confirmation:"password2")
      @userA.save
      @userB.save
      expect(@userB.errors.full_messages[0]).to eql("Email has already been taken")
    end

    it "should be invalid when password is less than 6 characters" do
      @user = User.new(first_name: "Billy", last_name: "Jean", email:"not_lover@one.com", password:"12345", password_confirmation:"12345")
      @user.save
      expect(@user.errors.full_messages[0]).to eql("Password is too short (minimum is 6 characters)")
    end

  end
end

=begin
   create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end
=end
