# Report Card Generator 

This script allows users to take csv (comma-separated values) files on student data and generate a text file that clearly displays a report card for each student. By running the script (intstructions below) along with the four csv files, you can quickly generate a report card for each student that breaks down each course, the final weighted grade for that course, and a total average. The four csv files should include the students info, course info, tests info, and the marks each student received.

## To run this script, first run "bundle install" and then run the following prompt in the terminal from the project's root directory: 
    
    ruby report-cards.rb [student_file] [course_file] [tests_file] [marks_file]

## For example:

    ruby report-cards.rb students.csv courses.csv tests.csv marks.csv

You must know the direct path to the four files and they must be in that exact order. To make it easier, you can put the four files in this project's folder.