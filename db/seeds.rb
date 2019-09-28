# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
    {
        email: 'bsinha2@ncsu.edu',
        encrypted_password: '$2a$11$goH1KszwZBFtTF.8ClKZm.WLdsu9B1N.Nu9tAWpCHAyX4upgwoYuq',
        role: 'admin'
    },
    {
        email: 'tanvi@ncsu.edu',
        encrypted_password: '$2a$11$goH1KszwZBFtTF.8ClKZm.WLdsu9B1N.Nu9tAWpCHAyX4upgwoYuq',
        role: 'librarian'
    },
    {
        email: 'vishva@ncsu.edu',
        encrypted_password: '$2a$11$goH1KszwZBFtTF.8ClKZm.WLdsu9B1N.Nu9tAWpCHAyX4upgwoYuq',
        role: 'student'
    },
]);

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

Library.create([
    {
        name: 'Hunt',
        location: 'Centennial',
        borrow_duration: 5,
        fine_per_day: 5
    },
    {
        name: 'D.H Hill',
        location: 'Hillsborough Street',
        borrow_duration: 10,
        fine_per_day: 3
    }
]);

UniversityLibraryMapping.create([
    {
        libraries_id: 1,
        universities_id: 1
    },
    {
        libraries_id: 2,
        universities_id: 1
    }
]);