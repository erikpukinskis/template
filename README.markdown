# Erik's App Template

This is just a little template I use to get Sinatra apps up and running.  Works on Heroku.

# Deployment

To download the code and deploy on heroku, install the heroku gem and do:

 git clone git@github.com:erikpukinskis/template.git your_project_name
 cd your_project_name
 heroku create your_project_name --stack bamboo-mri-1.9.1
 git push heroku master

And you should be running at http://your_project_name.heroku.com.  
