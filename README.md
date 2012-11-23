# Realtime chat webapplication

An experimental chat application using Ruby on Rails 3.2, Cramp, Redis, Thin and Angular.js. It demonstrates how you can easily add real-time capabilities to a (non-realtime synchronous) Rails application, using a chain of open source components. 

##1\. Dependencies

To run this application you need to have Ruby 1.9, Memcached and Redis installed. In most Linux distro's packages are available for these dependencies. On Mac, you'd probably have to 'brew install' stuff and in Windows you're probably fucked anyways. 

Most easy way of trying this out is to use a Fedora Linux VM and run 'sudo yum install rvm redis memcached'. Then run 'rvm install ruby-1.9.3' and you're almost ready to go. Installing redis and memcached from packages will set them as system services and start them. Both need to run, so check with 'ps aux' if that's the case. If not, run 'sudo service redis start' and 'sudo service memcached start'.


##2\. Run the webapplication

In the root of the application, run 'bundle' to install all gems for the webapplication. Then run 'bundle exec rake db:create db:schema:load' to create the sqlite database. Run 'rails server', the webapplication will now run on http://localhost:3000. Note: if the bundle command is unknown, run 'gem install bundler'. 

Having problems running the Rails application? Want to know how it works or change the behaviour? Check http://rubyonrails.org/ for more info.


##3\. Run the realtime application

Go to the cramp_app directory, run 'bundle' to install all gems for the realtime application. Run 'bundle exec thin -p 3001 --max-persistent-conns 1024 --timeout 0 -R config.ru start', the realtime application will now run on http://localhost:3001

Want to know more about Cramp realtime webapps? See http://cramp.in/ to read more about this webframework.

## Thanks

To all who contributed to Ruby, RoR, Devise, Dalli, Rabl, Thin, Redis, Cramp, Em-Hiredis, EventMachine and all those other great open source projects. You rule! You've made creating complex webapplications a joy. 
