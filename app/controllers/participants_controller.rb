class ParticipantsController < ApplicationController
  def index
    @registry = Registry.find(params[:registry_id])
    @participants = @registry.participants.group_by(&:coordinator)
  end

  def export
    @coordinators = Coordinator.all
    respond_to do |format|
      format.csv { send_data participants_to_csv, filename: "participants.csv" }
    end
  end

  private

  def participants_to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Name", "Gender", "Date of Birth", "Enrollment Date", "Method of Contact", "Remarks", "Coordinator"]
      @coordinators.each do |coordinator|
        coordinator.participants.each do |participant|
          csv << [participant.name, participant.gender, participant.date_of_birth, participant.enrollments.first.date_of_enrollment, participant.enrollments.first.method_of_contact, participant.enrollments.first.remarks, coordinator.name]
        end
      end
    end
  end
end
