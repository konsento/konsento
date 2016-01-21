# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'konsento'
set :repo_url, 'git@github.com:konsento/konsento.git'
set :deploy_to, '/home/deploy/www/konsento'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{.rbenv-vars}

set :puma_init_active_record, true

set :rbenv_type, :user
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :bundle_binstubs, nil

before 'deploy:compile_assets', 'bower:install'
