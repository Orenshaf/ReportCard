class Course
    attr_reader :name, :teacher
    def initialize(name, teacher)
        @name = name
        @teacher = teacher
    end
end