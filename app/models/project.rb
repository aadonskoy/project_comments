class Project < ApplicationRecord
  include AASM

  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 255 }

  delegate :events, to: :aasm, prefix: true

  aasm column: :state do
    state :not_started, initial: true
    state :in_progress
    state :on_hold
    state :completed

    event :start do
      transitions from: [:not_started, :on_hold], to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :pause do
      transitions from: :in_progress, to: :on_hold
    end
  end

  def events_names
    aasm_events.map(&:name)
  end
end
