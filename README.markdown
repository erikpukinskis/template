### Erik's App Template

This is just a little template I use to get little Sinatra apps up and running.  It's a 
minimal app that has a database-backed object (with Datamapper) and basic user authentication
(signing up, logging in, etc).  It installs on Heroku in a snap.

### Demo

You can see it running at [http://app-template.heroku.com](http://app-template.heroku.com/).

### Deployment

To download the code and deploy on heroku, install the heroku gem and do:

    git clone git@github.com:erikpukinskis/template.git your_project_name
    cd your_project_name
    heroku create your_project_name --stack bamboo-mri-1.9.1
    git push heroku master

And you should be running at http://your_project_name.heroku.com. It would
probably be good to set a secret key for your sessions too:

    heroku config:add SESSION_SECRET="<put your own random stuff here>"
