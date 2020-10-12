class Actor
    attr_reader :name
    attr_accessor :age, :rank

    @@all = []

    def self.all 
        @@all
    end

    def self.average_age
        self.all.map do |actor|
            actor.age
        end.reduce(:+)/self.all.length
    end
    
    def self.a_list
        self.all.select do |actor|
            actor.rank == "A"
        end
    end

    def self.most_successful
        highest_earnings = 0
        actor_with_highest_earnings = nil
        self.all.each do |actor|
            if actor.total_earnings > highest_earnings
                actor_with_highest_earnings = actor
                highest_earnings = actor.total_earnings
            end
        end
        actor_with_highest_earnings
    end

    def initialize(actor_args)
        @name = actor_args[:name]
        @rank = actor_args[:rank]
        @age = actor_args[:age]
        @@all << self
    end

    def sign_contract(movie, name, earnings)
        role_args = {actor: self, movie: movie, name: name, earnings: earnings}
        Role.new(role_args)
    end

    def total_roles
        Role.all.select do |role|
            role.actor == self
        end
    end

    def movies
        self.total_roles.map do |role|
            role.movie
        end
    end

    def blockbusters
        self.movies.select do |movie|
            Movie.blockbusters.include?(movie)
        end
    end

    def total_earnings
        self.total_roles.map do |role|
            role.movie.box_office * role.earnings
        end.reduce(:+)
    end

    def lie_about_age(fake_age)
        rank_arr = ["A", "B", "C", "D", "E"]
        rank_idx = rank_arr.index(self.rank)
        if fake_age > self.age && rank_idx < rank_arr.length - 1
            self.rank = rank_arr[rank_idx + 1]
        elsif fake_age < self.age && rank_idx > 0
            self.rank = rank_arr[rank_idx - 1]
        end
        self.age = fake_age
    end

end 