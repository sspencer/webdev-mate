#!/opt/local/bin/ruby -w
#
# =========================================================
# * NOTE *
# your ruby is probably located in /usr/bin/ruby, so
# change the first line to #!/usr/bin/ruby -w
# =========================================================
#
# Transparently saves all files in project locally and remotely.
# Press Command-Option-S to synchronize entire project from
# your Mac to your remote box.
#
# Create a command in TextMate's bundle editor with the following settings:
#    Save: All Files in Project
#    Input: None
#    Output: Show as Tool Tip
#    Activation: [Key Equivalent] ⌥⌘S
#
# In your TextMate Project, edit "Project Information" by setting the following 2 vars:
#    RSYNC_LOCAL:  /Users/steve/dev/myproject   (top of project on your Mac)
#    RSYNC_REMOTE: steve@myremovebox.example.com:/home/steve/public_html/myproj
#
# NOTE 
#    1. No trailing slashes above.
#    2. These are the exact same variables as in rsync_file.  
#       No need to set them twice.
#
# The files should already be checked out on your linux box because rsync won't
# won't create the directories.
#
# Make sure you can rsync to your remote box without entering a password 
# (copy id_rsa.pub over to remote ~/.ssh/authorized_keys)

local  = ENV["RSYNC_LOCAL"]
remote = ENV["RSYNC_REMOTE"]

# don't output error message cause the RSYNC vars don't have to be set
# (and we may not be in a project)
if (local.nil? || remote.nil?):
    exit
end

path = ENV["TM_PROJECT_DIRECTORY"][local.length .. -1]

output = `rsync -avz -e 'ssh -ax' --exclude=CVS --exclude=.DS_Store #{ENV['TM_PROJECT_DIRECTORY']}/ #{remote}#{path}/`

lines = output.split("\n")
puts "Project Synchronized!"
puts lines[-2]

# output is something like:
#    building file list ... done
#    ... files transfered, 1 per line ...
# 
#    sent 168694 bytes  received 2052 bytes  68298.40 bytes/sec
#    total size is 300920  speedup is 1.76