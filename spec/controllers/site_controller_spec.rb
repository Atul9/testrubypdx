require 'rails_helper'

RSpec.describe SiteController, type: :controller do
  let(:valid_session) { {} }

  describe "GET #contact" do 
    it "renders the contact template" do 
      get :contact, {}, valid_session
      expect(response).to render_template('contact')
    end
  end

  describe "POST #send_mail" do 
    let(:valid_params) { {:name => 'Foo', :email => 'bar@baz.com'} }

    before(:each) do 
      FactoryGirl.create(:user, id: 1)
    end

    it "sets admin" do 
      post :send_mail, valid_params, valid_session
      expect(assigns(:admin)).to eql User.first
    end
  end

  describe "GET #about" do 
    it "renders the about template" do 
      get :about, {}, valid_session
      expect(response).to render_template('about')
    end
  end

  describe "GET #admin" do 
    context "authorized" do 
      let(:user) { FactoryGirl.create(:user, id: 1) }

      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end

      it "redirects to meeting creation" do 
        get :admin, {}, valid_session
        expect(response).to redirect_to '/meetings/new'
      end
    end

    context "unauthorized" do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      end

      it "redirects to login" do 
        get :admin, {}, valid_session
        expect(response).to redirect_to '/login'
      end
    end
  end
end
