require 'pry'
class Comment
    attr_accessor :username, :comment, :index

    def initialize(name, comment, index)
        @username = name
        @comment = comment
        @index = index
    end

    def save
        CSV.open("./db/comment.csv", "ab") do |csv|
            csv << [@index, @username, @comment]
        end
    end

    def self.index_table(current_index)
        index_table = []
        CSV.read("./db/comment.csv").each do |csv_line|
            if csv_line[0].to_i == current_index
                index_table << [csv_line[1], csv_line[2]]
            end
        end
        return index_table
    end
end