require 'rails_helper'

RSpec.describe ActivitiesController, :type => :controller do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      expect(response).to be_success
    end
  end

  describe "GET 'add'" do
    it "returns http success" do
      get 'add'
      expect(response).to be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      expect(response).to be_success
    end
  end

end
