require './app'
require 'minitest/autorun'

describe User do

  describe "#Create" do
    describe "When a user is created" do
      it "it must be saved succesfuly" do
        @user = User.new(name: "Sophie", last_name: "Turner", email: "sophiet@gmail.com",age: 29, address: "cra 98")
        @user.save.must_equal(true)
      end
    end

    describe "When a user is going to be created and the required fields are not complete" do
      it "It must not allow it to be created without first name " do
        @user = User.new({name: "", last_name: "Cueto", email: "nsr.nsr@gmail.com"})
        @user.save.must_equal(false)
      end

      it "It must not allow it to be created without last name " do
        @user = User.new({name: "Lisa", last_name: "", email: "nsr.nsr@gmail.com"})
        @user.save.must_equal(false)
      end

      it "It must not allow it to be created without email " do
        @user = User.new({name: "Camila", last_name: "Cueto", email: ""})
        @user.save.must_equal(false)
      end
    end

    describe "When enter an email that is already in use" do
      it " It must not allow it to be created" do
        @user = User.new({name: "Camila", last_name: "Cueto", email: "zm@gmail.com"})
        @user.save.must_equal(false)
      end
    end
  end

  describe "Where" do
    describe "When we filter by name,lastname, email or age" do 
      it "Must gets the record that matches the name" do
        search = "Lola"
        @user = User.where("name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query OR age ILIKE :query", 
        query: "%#{search}%")
        @user.any?.must_equal(true)
      end

      it "Must gets the record that matches the age" do
        search = "18"
        @user = User.where("name ILIKE :query OR last_name ILIKE :query OR email ILIKE :query OR age ILIKE :query", 
        query: "%#{search}%")
        @user.any?.must_equal(true)
      end
    end

  end

  describe "#Update" do
    describe "When a user is updated correctly" do
      it "It must be updated successfully" do
        @user = User.find(55)
        atrrs = ({name:"Zayn",last_name: "Malik", email: "zm@gmail.com", age: 24, address:" Bradford, Reino Unido"})
        @user.update(atrrs).must_equal(true)
      end
    end

    describe "When a user is going to be updated and the required fields are not complete" do
      it "It must not allow it to be updated without first name" do
        @user = User.find(55)
        atrrs = ({name:"",last_name: "Malik", email: "zm@gmail.com", age: 24, address:"Londres"})
        @user.update(atrrs).must_equal(false)
      end

      it "It must not allow it to be updated without last name" do
        @user = User.find(55)
        atrrs = ({name:"Zayn",last_name: "", email: "zm@gmail.com", age: 24, address:"Londres"})
        @user.update(atrrs).must_equal(false)
      end

      it "It must not allow it to be updated without email" do
        @user = User.find(55)
        atrrs = ({name:"Zayn",last_name: "Malik", email: "", age: 24, address:"Londres"})
        @user.update(atrrs).must_equal(false)
      end
    end
  end

  describe "#Find" do
    describe "When searching  for a user by ID" do
      it "It must show the user's data with that ID " do
        @user = User.find(55)[:name].must_equal("Zayn")
      end
    end
  end

  describe "#Delete" do
    describe "When a record is deleted successfully" do
      it "It must delete the user" do
        @user = User.delete(97).must_equal(1)
      end
    end
  end
end
