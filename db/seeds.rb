# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.create([
    {
        isbn: '0-7475-3269-9',
        title: "Harry Potter and the sorcer's stone",
        author: "J.K Rowling",
        language: "English",
        date_published: "2019-09-25",
        edition: "1",
        front_cover_img: "",
        subject: "Fiction",
        summary: "this is a test summary"
    }
]);

University.create([
    {
        name: 'North Carolina State University',
    },
    {
        name: 'University of North Carolina',
    },
    {
        name: 'Duke',
    }
]);