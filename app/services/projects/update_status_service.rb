module Projects
  class UpdateStatusService
    def initialize(project:, event:)
      @project = project
      @event = event
    end

    def call
      return false unless @project.events_names.include?(@event.to_sym)

      @project.public_send("#{@event}!")
      @project
    rescue AASM::InvalidTransition => _
      false
    end
  end
end
