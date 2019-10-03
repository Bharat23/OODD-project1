

# Library Management System

## Db setup

- Create user
    - `CREATE USER railsapp WITH ENCRYPTED PASSWORD 'railsapp';`
- Grant SuperUser access
    - `ALTER ROLE railsapp WITH superuser`

## Running instructions

- run `rake db:migrate` to create schemas
- run `rake db:seed` to import initial data
- run `rails s` to start the application
- In your browser call this url `http://localhost:3000/config/createusers` to create initial users
    - Admin account:
        - username: admin@lib.com
        - password: 123456
    - Librarian account:
        - username: librarian@lib.com
        - password: 123456
    - Student account:
        - username: student@lib.com
        - password: 123456

### Actions

- #### Librarian
    - To view books in library click on show library books
    - To add book to library 
        - navigate to `show available book` list and edit the book
        - add the count and the book will be assigned to the library the librarian belong to
    - To show all the student belonging to my library click on `show students` list item

- #### Admin
    - To view all books and related actions navigate to `show all books`. Add books to add it to available list which can be added by librarian to their library
    - To approve requests for librarian request click on signup approval link and select approve or reject from the list items
    - Show all librarian lists all the librarians across the system and admin can perform actions like add, delete, edit.
    - Show all students across the system and admin can perform actions like add, delete, edit.
    - Show all universities link to list, edit, add and delete universities.
    - To view book issue history navigate to the book list and click on `Borrow History` to view the entire time ordered history.

- #### Student
    - User can view all the books and issue them by navigating through `show available books>show>checkout`

- All the users can edit their profile by going to my profile.