# Pressto

A Capistrano based, Composer backed boilerplate project for easy WordPress
deployments

## Background

Before using this project, I strongly advise reading these articles to get a
good overview on how this should work, and what the setup will entail:

- [Roots.io: Using Composer with WordPress](roots.io/using-composer-with-wordpress/)
- [Mixd.co.uk: deploying WordPress using Git and Capistrano](http://www.mixd.co.uk/blog/deploying-wordpress-using-git-and-capistrano/)


## Requirements

- [Capistrano v3](www.capistranorb.com)
- [Capistrano/Composer](https://github.com/capistrano/composer)
- [Composer](getcomposer.org/) on each of your environments (dev/production)

## Installation

````bash
$ git clone https://raw.github.com/netsensei/pressto
$ cd pressto
$ composer install
````

You should end up with a folder called `pressto` with an extra subfolder `wp`
inside it. This is the actual WordPress installation.

Note that you are installing WordPress from a subfolder on your host. You'll
need to follow the [Giving WordPress its own directory](codex.wordpress.org/Giving_WordPress_Its_Own_Directory) steps to make sure everything gets
loaded correctly.

## Configuration

You'll need a private Git repository which will contain this project:

1. Create a repo on i.e. Github or BitBucket or ...
2. Either remove the `.git` folder in this project entirely and do a `git init`
or add your project repo as a remote branch (less recommended)
3. Important: commit the `composer.lock` file after running composer.
4. Push the project to your project repo.

Next up, you'll need to configure the Capistrano deployment scripts:

In `config/deploy.rb` change these lines:

The project name:

````ruby
set :application, 'projectname'
````

The pointer to your project repo:

````ruby
set :repo_url, 'git@bitbucket.org:user/repo.git'
````

SSH connection data of your destination server where you want to deploy to. This
assumes you've configured you're sshd and account with a public/private key.

````ruby
role :app, %w{user@ssh-destination}
````

In `config/deploy/{production|staging}.rb` change these lines:

The location on the server where the production version will live:

````ruby
set :deploy_to, '/var/www/example.com'
````

The branch in you project repo which represents the production version:

````ruby
set :branch, "master"
````
## WordPress Configuration

Capistrano keeps static files (ie images, configuration,...) in a separate
`shared` folder on the remote host.

You'll need to add an `uploads/` folder. This contains all your uploaded media.

You'll need to add a `config-{development|production|staging}.php` file. This
file contains your environment specific db settings.

Example:

````php
<?php

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'PROD_project');

/** MySQL database username */
define('DB_USER', 'PROD_dbuser');

/** MySQL database password */
define('DB_PASSWORD', 'password');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');
````

Capistrano will automatically symlink to these items with each deployment.

## Deployement

If all went well, deployment to i.e. production should not entail much more then
this:

````bash
$ cap production deploy
````

## Upgrading WordPress

1. Open `composer.json` and change version number to reflect the upgrade.
2. Run `composer update` to update locally. This should update your lock file.
3. Push the updated json and lock file to your repo.
4. Run `cap production deploy` to deploy your changes and upgrade remotely.
5. Go to your site, login and perform any pending database updates.

## Credits

Matthias "Netsensei" Vandermaesen
[http://www.colada.be](http://www.colada.be)
[@netsensei](https://twitter.com/netsensei)


