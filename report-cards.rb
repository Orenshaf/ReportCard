require "csv"
require_relative "student"
require_relative "course"
require_relative "test"

class ReportCards
    attr_accessor :cards, :courses, :tests
    def initialize
        @students = Hash.new
        @courses = Hash.new
        @tests = Hash.new

        self.add_students
        self.add_courses
        self.add_tests
        self.add_marks_to_students
        self.generate_file
    end

    def add_students
        student_list = CSV.read(ARGV[0]) 
        student_list.shift
        student_list.each do |row|
            @students[row[0].to_i] = Student.new(row[1])
        end
    end

    def add_courses
        course_list = CSV.read(ARGV[1])
        course_list.shift

        course_list.each do |row|
            @courses[row[0].to_i] = Course.new(row[1], row[2])
        end
    end

    def add_tests
        test_list = CSV.read(ARGV[2])
        test_list.shift
        test_list.each do |row|
            @tests[row[0].to_i] = Test.new(row[1].to_i, row[2].to_i)
        end
    end

    def add_marks_to_students
        marks = CSV.read(ARGV[3])
        marks.shift
        marks.each do |row|
            student_id = row[1].to_i
            course = @courses[@tests[row[0].to_i].course_id]
            weight = @tests[row[0].to_i].weight
            grade = row[2].to_i * weight / 100.00

            @students[student_id].add_course(course)
            @students[student_id].add_grade(course, grade)
        end
    end

    def generate_file 
        out_file = File.new("report_cards.txt", "w")
        @students.each do |id, info|
            out_file.puts("Student Id: #{id}, name: #{info.name}")

            total_scores = info.courses.values.flatten.reduce { |a, b| a + b }
            total_average = total_scores / info.courses.values.length

            out_file.puts("Total Average: \t\t#{total_average.round(2)}%")
            out_file.puts("\n")

            info.courses.each do |course, grades|
                out_file.puts("\tCourse: #{course.name}, Teacher: #{course.teacher}")
                final_grade = self.calulate_final_grade(grades)
                out_file.puts("\tFinal Grade: \t#{final_grade.round(2)}0%")
                out_file.puts("\n")
            end
            out_file.puts("\n")
            out_file.puts("\n")
        end

        File.open(out_file)
    end

    def calulate_final_grade(grades)
        grades.reduce { |a, b| a + b }
    end

    def calulate_total_average
    end
end

cards = ReportCards.new