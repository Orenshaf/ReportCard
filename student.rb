class Student
    attr_accessor :name, :courses

    def initialize(name)
        @name = name
        @courses = Hash.new {|h,k| h[k] = []}
    end

    def add_course(course)
        @courses[course]
    end

    def add_grade(course, grade) 
        @courses[course].push(grade)
    end
end
