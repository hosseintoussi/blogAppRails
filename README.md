### Blog app on rails ###

#### How do I get started? ####
- Clone the repo.
- Run `bundle install`.
- Then setup your db; you may use `rake db:setup`. If you don't use setup, ensure that you run the seed file to populate the default roles.
- Next would be to start the app. You will need to install foreman gem (`gem install foreman`) if you don't have it already, and run
 `foreman start`
This will start sunspot solr, and run your rails app on a webrick server usning port 3000.

- Note for tests:
For rspec tests to pass, you will need to run `rake sunspot:solr:run RAILS_ENV=test` to start sunspot solr in test env.

######There are 3 types of users:######

- Admin: can manage everything.
- Moderator: can manage everything, but cannot manage users.
- User: can create articles, comment, and manage their own posts but not the comments on their posts.

New posts will be automatically added to the index for search, but in case you need to reindx, you can run `bundle exec rake sunspot:reindex`.

#### Overview of the dashboard ####
![Screen Shot 2015-10-10 at 8.21.06 PM.png](https://bitbucket.org/repo/eMrKMB/images/485102621-Screen%20Shot%202015-10-10%20at%208.21.06%20PM.png)

#### Creating and editing Blogs ####
![Screen Shot 2015-10-02 at 9.42.49 PM.png](https://bitbucket.org/repo/eMrKMB/images/2714391210-Screen%20Shot%202015-10-02%20at%209.42.49%20PM.png)

#### Blog overview with comments ####
![Screen Shot 2015-10-02 at 9.41.41 PM.png](https://bitbucket.org/repo/eMrKMB/images/1899669627-Screen%20Shot%202015-10-02%20at%209.41.41%20PM.png)