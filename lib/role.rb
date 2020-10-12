class Role
    attr_reader :actor, :movie, :name, :earnings

    @@all = []

    def self.all
        @@all 
    end

    def initialize(role_args)
        @actor = role_args[:actor]
        @movie = role_args[:movie]
        @name = role_args[:name]
        @earnings = role_args[:earnings]
        @@all << self
    end
end