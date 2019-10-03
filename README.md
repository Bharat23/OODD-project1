

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
