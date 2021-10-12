require_relative "room"


class Hotel
    attr_reader :name, :rooms

  def initialize(name, capacities)
      @name = name
      @rooms = {}

      capacities.each do |room, capacity|
        @rooms[room] = Room.new(capacity)
      end 
  end

  def name
      @name.split.map {|part| part.capitalize }.join(" ")
  end

  def room_exists?(room_name)
    if rooms.has_key?(room_name)
        return true
    else
        return false
    end
  end 

  def check_in(person, room_name)
    if !room_exists?(room_name)
        p 'sorry, room does not exist'
    else
        if @rooms[room_name].add_occupant(person)
            puts "check in successful"
        else
            puts "sorry, room is full"
        end 
    end 
  end

  def has_vacancy?
      room_instances = rooms.values
      if room_instances.all? { |instance| instance.full? }
        return false
      else
        return true
      end 
  end

  def list_rooms
    rooms.each  do |room, instance|
        puts "#{room} + #{instance.available_space}"
    end 
  end

end
