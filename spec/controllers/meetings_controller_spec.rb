require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe MeetingsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Meeting. As you add validations to Meeting, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { date: DateTime.now }
  }

  let(:invalid_attributes) {
    { date: nil }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MeetingsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #show" do
    let(:meeting) { FactoryGirl.create(:meeting) }

    it "assigns the requested meeting as @meeting" do
      get :show, {:id => meeting.to_param}, valid_session
      expect(assigns(:meeting)).to eq(meeting)
    end

    it "renders the show template" do 
      get :show, {:id => meeting.to_param}, valid_session
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    context "authorized" do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "assigns a new meeting as @meeting" do
        get :new, {}, valid_session
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end
    end

    context "unauthorized" do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      end

      it "doesn\'t assign a new meeting" do 
        get :new, {}, valid_session
        expect(assigns(:meeting)).to be nil
      end

      it "redirects to the login page" do 
        get :new, {}, valid_session
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "GET #edit" do
    context "authorized" do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "assigns the requested meeting as @meeting" do
        meeting = FactoryGirl.create(:meeting)
        get :edit, {:id => meeting.to_param}, valid_session
        expect(assigns(:meeting)).to eq(meeting)
      end

      it "renders the 'edit' template" do 
        meeting = FactoryGirl.create(:meeting)
        get :edit, {:id => meeting.to_param}, valid_session
        expect(response).to render_template "edit"
      end
    end

    context "unauthorized" do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      end

      it "redirects to the login page" do 
        meeting = FactoryGirl.create(:meeting)
        get :edit, {:id => meeting.to_param}, valid_session
        expect(response).to redirect_to '/login'
      end
    end
  end

  describe "GET #past" do 
    it "assigns the past meetings as @meetings" do 
      past = FactoryGirl.create_list(:past_meeting, 2)
      upcoming = FactoryGirl.create(:upcoming_meeting)
      get :past, valid_session
      expect(assigns(:meetings)).to eq past
    end
  end

  describe "GET #upcoming" do 
    it "assigns the upcoming meetings as @meetings" do 
      upcoming = [FactoryGirl.create(:upcoming_meeting)]
      past = FactoryGirl.create_list(:past_meeting, 2)
      get :upcoming, valid_session
      expect(assigns(:meetings)).to eq upcoming
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Meeting" do
        expect {
          post :create, {:meeting => valid_attributes}, valid_session
        }.to change(Meeting, :count).by(1)
      end

      it "assigns a newly created meeting as @meeting" do
        post :create, {:meeting => valid_attributes}, valid_session
        expect(assigns(:meeting)).to be_a(Meeting)
        expect(assigns(:meeting)).to be_persisted
      end

      it "redirects to the created meeting" do
        post :create, {:meeting => valid_attributes}, valid_session
        expect(response).to redirect_to(Meeting.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved meeting as @meeting" do
        post :create, {:meeting => invalid_attributes}, valid_session
        expect(assigns(:meeting)).to be_a_new(Meeting)
      end

      it "re-renders the 'new' template" do
        post :create, {:meeting => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {date: Date.tomorrow}
      }

      context 'authorized' do 
        before(:each) do 
          @user = FactoryGirl.create(:user)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        end

        it "updates the requested meeting" do
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => new_attributes}, valid_session
          meeting.reload
          expect(meeting.date).to eq Date.tomorrow
        end

        it "assigns the requested meeting as @meeting" do
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
          expect(assigns(:meeting)).to eq meeting
        end

        it "redirects to the meeting" do
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => valid_attributes}, valid_session
          expect(response).to redirect_to(meeting)
        end
      end

      context 'unauthorized' do 
        before(:each) do 
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        end

        it "doesn't update the requested meeting" do 
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => new_attributes}, valid_session
          meeting.reload
          expect(meeting.description).not_to eq 'Foo bar baz'
        end

        it "redirects to the login page" do 
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => new_attributes}, valid_session
          expect(response).to redirect_to('/login')
        end
      end
    end

    context "with invalid params" do
      context 'authorized' do 
        before(:each) do 
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(FactoryGirl.create(:user))
        end

        it "assigns the meeting as @meeting" do
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
          expect(assigns(:meeting)).to eq(meeting)
        end

        it "re-renders the 'edit' template" do
          meeting = FactoryGirl.create(:meeting)
          put :update, {:id => meeting.to_param, :meeting => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context 'authorized' do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "destroys the requested meeting" do
        meeting = FactoryGirl.create(:meeting)
        expect {
          delete :destroy, {:id => meeting.to_param}, valid_session
        }.to change(Meeting, :count).by(-1)
      end

      it "redirects to the meetings list" do
        meeting = FactoryGirl.create(:meeting)
        delete :destroy, {:id => meeting.to_param}, valid_session
        expect(response).to redirect_to(meetings_url)
      end
    end

    context 'unauthorized' do 
      before(:each) do 
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
      end

      it "doesn\'t destroy the requested meeting" do 
        meeting = FactoryGirl.create(:meeting)
        expect {
          delete :destroy, {:id => meeting.to_param}, valid_session
        }.not_to change(Meeting, :count)
      end

      it "redirects to the login page" do 
        meeting = FactoryGirl.create(:meeting)
        delete :destroy, {:id => meeting.to_param}, valid_session
        expect(response).to redirect_to('/login')
      end
    end
  end

end
