require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    let(:valid_attributes) do
      {
        title: "Project title",
        description: "Project description"
      }
    end

    it "valid with valid_attributes" do
      project = Project.new(valid_attributes)

      expect(project).to be_valid
      expect(project.errors.messages).to be_empty
    end

    it "invalid without title" do
      project = Project.new(valid_attributes.except(:title))

      expect(project).to be_invalid
      expect(project.errors.messages).to eq({ title: ["can't be blank"] })
    end

    it "invalid with loo long title" do
      project = Project.new(valid_attributes.merge(title: "a" * 110))

      expect(project).to be_invalid
      expect(project.errors.messages).to eq({ title: ["is too long (maximum is 100 characters)"] })
    end

    it "invalid without description" do
      project = Project.new(valid_attributes.except(:description))

      expect(project).to be_invalid
      expect(project.errors.messages).to eq({ description: ["can't be blank"] })
    end

    it "invalid with loo long description" do
      project = Project.new(valid_attributes.merge(description: "a" * 300))

      expect(project).to be_invalid
      expect(project.errors.messages).to eq({ description: ["is too long (maximum is 255 characters)"] })
    end
  end

  describe "states" do
    it "has default state" do
      project = Project.new

      expect(project.state).to eq("not_started")
    end

    it "change states correctly" do
      project = create(:project)

      expect(project).to transition_from(:not_started).to(:in_progress).on_event(:start)
      expect(project).to transition_from(:in_progress).to(:completed).on_event(:complete)
      expect(project).to transition_from(:in_progress).to(:on_hold).on_event(:pause)
      expect(project).to_not transition_from(:not_started).to(:completed).on_event(:complete)
      expect(project).to_not transition_from(:on_hold).to(:completed).on_event(:complete)
    end
  end
end
