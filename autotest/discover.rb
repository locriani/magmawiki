Autotest.add_hook :initialize do |autotest|
    %w{.git .DS_store db log tmp rerun.txt}.each { |e| autotest.add_exception(e) }
end

Autotest.add_discovery { "rails" }
Autotest.add_discovery { "rspec2" }
