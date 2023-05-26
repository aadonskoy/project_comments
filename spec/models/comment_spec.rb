require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    let(:project) { create(:project) }
    let(:valid_attributes) do
      {
        project: project,
        username: "User Name",
        text: "Comment body"
      }
    end

    it "valid with valid_attributes" do
      comment = Comment.new(valid_attributes)

      expect(comment).to be_valid
      expect(comment.errors.messages).to be_empty
    end

    it "invalid without username" do
      comment = Comment.new(valid_attributes.except(:username))

      expect(comment).to be_invalid
      expect(comment.errors.messages).to eq({ username: ["can't be blank"] })
    end

    it "invalid with loo long username" do
      comment = Comment.new(valid_attributes.merge(username: "a" * 110))

      expect(comment).to be_invalid
      expect(comment.errors.messages).to eq({ username: ["is too long (maximum is 100 characters)"] })
    end

    it "invalid without text" do
      comment = Comment.new(valid_attributes.except(:text))

      expect(comment).to be_invalid
      expect(comment.errors.messages).to eq({ text: ["can't be blank"] })
    end

    it "invalid with loo long text" do
      comment = Comment.new(valid_attributes.merge(text: "a" * 300))

      expect(comment).to be_invalid
      expect(comment.errors.messages).to eq({ text: ["is too long (maximum is 255 characters)"] })
    end
  end
end
