## Intention
A diary to record all those wonderful things you have discovered and expect to recall forever...  
..except (if like me) you will only have a very hazy memory of them a few days (hours?) later unless you immediately document, save and review them.  
Enter **Technical Diary**. Think of it as an upside-down ToDo list (a ToDone list!)  
<img src='public/technical-diary.png' style="max-width: 300px;">

## Rails commands
These are the early Rails commands that gave this project first life: 

    $ rails new techincal_diary -c=bootstrap -d=postgresql
    $ cd technical_diary/
    $ touch .yarnrc.yml
    (add nodeLinker: node-modules to .yarnrc.yml)
    (Delete the pnp files)
    $yarn install (node_modules appears)
    $ bin/rails action_text:install
    $ bundle
    $ bin/rails db:migrate
    $ rails g scaffold item date:date:index topic:index subtopic:index
    $ rails db:migrate
    $ bin/dev [change port to 4000 if 3000 is in use in bin/dev]


## Sanity Checks
### Check for PostgreSQL:
database.yml should reference postgresql not sqlite

###  Check for Bootstrap:
index.html.erb

    <h1 class='text-primary'>Items</h1>

browse localhost:4000/items and see blue text

