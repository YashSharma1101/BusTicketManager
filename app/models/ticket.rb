# app/models/ticket.rb
class Ticket < ApplicationRecord
  # after_create :send_ticket_created_email
  # after_update :send_ticket_created_email
  belongs_to :user
  belongs_to :booked_by, class_name: 'User', foreign_key: 'booked_by_id', optional: true
  belongs_to :booked_for, class_name: 'User', foreign_key: 'booked_for_id', optional: true
  has_many :ticket_bookings, dependent: :destroy

  validates :user_id, :booked_by, :booked_for, :week_date, presence: true  
  validates :booked_count, presence: true
  validates :extra_charges, numericality: { greater_than_or_equal_to: 0 }
  validates :week_date, presence: true
  validate :different_user_and_booked_by
  validate :different_user_and_booked_for
  validate :unique_week#, on: :create

  def send_ticket_created_email(current_user)
    booked_by = User.find(self.booked_by_id)
    booked_for = User.find(self.booked_for_id)
    TicketMailer.ticket_created_email(self, HomeController.calculate_owe_summary(booked_by), booked_by).deliver_now
    TicketMailer.ticket_created_email(self, HomeController.calculate_owe_summary(booked_for), booked_for).deliver_now
    # TicketMailer.ticket_created_email(self, HomeController.calculate_owe_summary(current_user), current_user).deliver_now
  end

  private

  def different_user_and_booked_by
    if booked_by_id.present? && user_id != booked_by_id
      errors.add(:booked_by_id, "should be same as user")
    end
  end 

  def different_user_and_booked_for
    if booked_for_id.present? && user_id == booked_for_id
      errors.add(:booked_for_id, "should be different from user")
    end
  end

  def unique_week
    existing_ticket = Ticket.where.not(id: id).find_by(user_id: user_id, booked_for_id: booked_for_id, week_number: week_number, year: year)
    # existing_ticket = Ticket.find_by(user_id: user_id, booked_for_id: booked_for_id, week_number: week_number, year: year)
    # existing_ticket = Ticket.where.not(id: id, booked_for: booked_for).find_by(week_number: week_number, year: year, user_id: user_id)

    if existing_ticket.present?
      errors.add(:base, "Tickets for the week of selected date are already booked")
    end
  end
end
