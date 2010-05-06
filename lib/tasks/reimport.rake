
namespace :db do

  def do_task(name)
    puts "#" * 80
    puts "## #{name}"
    puts "#" * 80
    Rake::Task[name].invoke
    puts
  end

  desc "Reimport..."
  task :reimport => [:environment] do
    do_task("db:drop")
    do_task("db:create")
    do_task("db:migrate")
    do_task("db:fixtures:load")

    do_task("db:test:clone_structure")
    #do_task("annotate_models")
  end
  
end
