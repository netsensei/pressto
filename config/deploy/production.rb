set :stage, :production

set :deploy_to, '/var/www/example.com'
set :linked_files, %w{config-production.php}
set :branch, "master"
