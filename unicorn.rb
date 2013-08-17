worker_processes 2
working_directory "/sites/predictions.robm.me.uk"

preload_app true

timeout 30

listen "/tmp/predictions.sock", :backlog => 64

pid "/tmp/predictions.pid"

stderr_path "/sites/predictions.robm.me.uk/err.log"
stdout_path "/sites/predictions.robm.me.uk/out.log"
