require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let!(:project) { create(:project) }
    let(:comment_attributes) { attributes_for(:comment) }

    context "with valid attributes" do
      it "returns http success" do
        post :create, params: { project_id: project.id, comment: comment_attributes }

        expect(response).to redirect_to(project)
      end
    end

    it "throws not found exception" do
      expect do
        post :create, params: { project_id: 0, comment: attributes_for(:comment) }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end

    context "with invalid attributes" do
      let(:comment_attributes) { attributes_for(:comment, text: nil) }

      it "returns http unprocessable_entity" do
        post :create, params: { project_id: project.id, comment: comment_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
