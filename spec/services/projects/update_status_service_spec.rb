require "rails_helper"

RSpec.describe Projects::UpdateStatusService do
  let(:project) { create(:project) }
  subject { described_class.new(project: project, event: event).call }

  describe "#call" do
    context "when correct event" do
      let(:event) { "start" }

      it "returns true" do
        expect(subject.state).to eq("in_progress")
      end
    end

    context "when incorrect event" do
      let(:event) { "incorrect_event" }

      it "returns false" do
        expect(subject).to be_falsey
        expect(project.state).to eq("not_started")
      end
    end

    context "when event is not allowed" do
      let(:event) { "complete" }

      it "returns false" do
        expect(subject).to be_falsey
        expect(project.state).to eq("not_started")
      end
    end
  end
end
