Specifications for the Sinatra Assessment
Specs:

[x] Use Sinatra to build the app
[x] Use ActiveRecord for storing information in a database
[x] Include more than one model class (e.g. User, Post, Category)
    Models: User, Yarn
[x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
    User has_many Yarns
[x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
    Yarn belongs_to User
[x] Include user accounts with unique login attribute (username or email)
    Unique username
[x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
    [x] Create
    [x] Read
    [x] Update
    [x] Delete
[x] Ensure that users can't modify content created by other users
    Edit Yarn:
        [x] User can't edit a yarn that doesn't belong to them
        [x] User can't delete a yarn that doesn't belong to them
        [x] User's all yarn page shows only yarns they have created
[x] Include user input validations
    Login:
        [x] User can't submit a blank login
        [x] User can't log in with an account that doesn't exist in the db
    Sign Up:
        [x] User can't sign up with a blank form
        [] User can't sing up with an account that already exists
[] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
[] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm:

[x] You have a large number of small Git commits
[x] Your commit messages are meaningful
[x] You made the changes in a commit that relate to the commit message
[x] You don't include changes in a commit that aren't related to the commit message