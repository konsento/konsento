# config valid only for current version of Capistrano
lock '3.8.1'

set :application, 'konsento'
set :repo_url, 'git@github.com:konsento/konsento.git'
set :deploy_to, '/home/deploy/www/konsento'

ld = %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]
set :linked_dirs, ld
set :linked_files, %w[.rbenv-vars]

set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'

rbenv_prefix = "RBENV_ROOT=#{fetch(:rbenv_path)}"
rbenv_prefix << " RBENV_VERSION=#{fetch(:rbenv_ruby)}"
rbenv_prefix << " #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_prefix, rbenv_prefix

set :rbenv_map_bins, %w[rake gem bundle ruby rails puma pumactl]

set :puma_threads, [0, 2]
set :puma_workers, 2

set :bundle_binstubs, nil

before 'deploy:compile_assets', 'bower:install'
