class Movie
    attr_reader :title, :year, :box_office

    @@all = []

    def self.all
        @@all
    end

    def self.blockbusters
        self.all.select do |movie|
            movie.box_office > 50000000
        end
    end

    def self.box_office_total_by_year(year)
        movies_from_year = self.all.select do |movie|
            movie.year == year
        end
        movies_from_year.map do |movie|
            movie.box_office
        end.reduce(:+)
    end

    def initialize(movie_args)
        @title = movie_args[:title]
        @year = movie_args[:year]
        @box_office = movie_args[:box_office]
        @@all << self
    end

    def within_five_years
        my_year = self.year
        self.class.all.select do |movie|
            movie.year >= my_year - 5 && movie.year <= my_year + 5 && movie != self
        end
    end

    def cast_role(actor, character_name, earnings)
        Role.new({actor: actor, movie: self, name: character_name, earnings: earnings})
    end

    def stars_by_rank
        roles = Role.all.select do |role|
            role.movie == self
        end
        actors = roles.map do |role|
            role.actor
        end
        actors.sort_by do |actor|
            actor.rank 
        end
    end

end 