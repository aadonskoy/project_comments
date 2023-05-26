require "rails_helper"

RSpec.describe ProjectsController, type: :controller do
  let(:project_attributes) { attributes_for(:project) }

  describe "GET #index" do
    let!(:project) { create(:project) }

    it "returns http success" do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    let!(:project) { create(:project) }

    it "returns http success" do
      get :edit, params: { id: project.id }

      expect(response).to have_http_status(:success)
    end

    it "throws ActiveRecord::RecordNotFound exception" do
      expect { get :edit, params: { id: 0 } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, params: { project: project_attributes }

      expect(response).to redirect_to(projects_url)
    end

    it "throws ActionController::ParameterMissing exception" do
      expect { post :create }.to raise_error(ActionController::ParameterMissing)
    end

    it "resturn unprocessable entity" do
      post :create, params: { project: project_attributes.except(:title) }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT #update" do
    let!(:project) { create(:project) }

    it "returns http success" do
      put :update, params: { id: project.id, project: project_attributes }

      expect(response).to redirect_to(projects_url)
    end

    it "throws ActionController::ParameterMissing exception" do
      expect { put :update, params: { id: project.id } }.to raise_error(ActionController::ParameterMissing)
    end

    it "throws ActiveRecord::RecordNotFound exception" do
      expect { put :update, params: { id: 0, project: project_attributes } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "resturn unprocessable entity" do
      put :update, params: {
        id: project.id,
        project: project_attributes.merge(title: "a" * 700)
      }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT #update_status" do
    let!(:project) { create(:project) }

    it "returns http success" do
      put :update_status, params: { id: project.id, event: { start: true } }

      expect(response).to redirect_to(project_url(project))
    end

    it "throws ActionController::ParameterMissing exception" do
      expect { put :update_status, params: { id: project.id } }.to raise_error(ActionController::ParameterMissing)
    end

    it "throws ActiveRecord::RecordNotFound exception" do
      expect { put :update_status, params: { id: 0, event: { start: true } } }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "resturn unprocessable entity" do
      put :update_status, params: { id: project.id, event: { invalid: true } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #show" do
    let!(:project) { create(:project) }

    it "returns http success" do
      get :show, params: { id: project.id }

      expect(response).to have_http_status(:success)
    end

    it "throws ActiveRecord::RecordNotFound exception" do
      expect { get :show, params: { id: 0 } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
