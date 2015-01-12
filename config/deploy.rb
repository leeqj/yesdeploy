# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'yes2'
set :repo_url, 'http://svn.leho.com/svn/yes_bbc/trunk/'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '/usr/share/nginx/www'

# Default value for :scm is :git
 set :scm, :svn

# Default value for :format is :pretty
 set :format, :pretty

# Default value for :log_level is :debug
 set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
 set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 3 do
      # Here we can do anything such as:
       within release_path do
         execute :rake, 'cache:clear'
       end
    end
  end

  task :updatecmd  do
    #["config/database.yml", "config/config.yml"].each do |path|
      #run "ln -fs #{shared_path}/#{path} #{release_path}/#{path}"
    #end
	  on roles(:web) do
	    execute "echo 'finish will exe update common' > ~/tttt.txt"
  	end
  end
	#task :updatecmd do
		#execute "echo 'finish will exe update common'"
	#	sh '/usr/share/nginx/www/current/app/base/cmd update'
	#end

  task :cmdupdate do
  	on primary roles(:web) do
      # as 'vagrant' do
        within '/usr/share/nginx/www/current/app/base/' do
          puts capture(:php, 'cmd','update')
        end
      # end
  		# execute "echo 1 >/home/vagrant/text.t"
  	end
  end
	after :finish, :cmdupdate
end
# after  "deploy", "deploy:cmdupdate"
