class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if can_ride
      subtract_tickets
      adjust_mood
      "Thanks for riding the #{attraction.name}!"
    elsif enough_tickets && !tall_enough
      "Sorry. #{not_tall_enough}."
    elsif tall_enough && !enough_tickets
      "Sorry. #{not_enough_tickets}."
    else
      "Sorry. #{not_enough_tickets}. #{not_tall_enough}."
    end
  end

  def subtract_tickets
    current_tickets = user.tickets.to_i - attraction.tickets.to_i
    user.update(tickets: current_tickets)
  end

  def adjust_mood
    current_happiness = user.happiness.to_i + attraction.happiness_rating.to_i
    current_nausea = user.nausea.to_i + attraction.nausea_rating.to_i
    user.update(happiness: current_happiness, nausea: current_nausea)
  end

  def tall_enough
    user.height.to_i >= attraction.min_height.to_i
  end

  def not_tall_enough
    "You are not tall enough to ride the #{self.attraction.name}"
  end

  def enough_tickets
    user.tickets.to_i >= attraction.tickets.to_i
  end

  def not_enough_tickets
    "You do not have enough tickets to ride the #{self.attraction.name}"
  end

  def can_ride
    tall_enough && enough_tickets
  end
end
