set :application, 'projectname'
set :repo_url, 'git@bitbucket.org:user/repo.git'

set :ssh_options, { :forward_agent => true }

set :deploy_via, :remote_cache
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"]

role :app, %w{user@ssh-destination}

set :linked_dirs, %w{app/uploads}

set :composer_install_flags, '--no-dev --prefer-dist --no-scripts --quiet --optimize-autoloader'
set :composer_roles, :all

namespace :deploy do

  desc 'Clear composer cache'
  task :clear_cache do
    Rake::Task["composer:run"].reenable
    invoke "composer:run", :clearcache
  end
  after :cleanup, 'deploy:clear_cache'

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :finishing, 'deploy:cleanup'

end
