class Gossip
    attr_accessor :name, :value

    def initialize(name, value)
        @name = name
        @value = value
    end

    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@name, @value]
        end
    end

    def self.all
        all_gossips = []
        CSV.read("./db/gossip.csv").each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
		return Gossip.all[id]
	end

    def self.update(author, content, id)
		gossip_array = self.all
		gossip_array[id.to_i].name = author
		gossip_array[id.to_i].value = content
		File.open("./db/gossip.csv", 'w') {|file| file.truncate(0) }
		gossip_array.each do |gossip|
			gossip.save
		end	
    end
end