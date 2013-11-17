set :stage, :staging

set :deploy_to, '/var/www/staging.example.com'
set :linked_files, %w{config-staging.php}
set :branch, "staging"
