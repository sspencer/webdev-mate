#!/opt/local/bin/ruby -w
#
# =========================================================
# * NOTE *
# your ruby is probably located in /usr/bin/ruby, so
# change the first line to #!/usr/bin/ruby -w
# =========================================================
#
# Transparently saves current file locally and remotely when you press ⌘S.
#
# Create a command in TextMate's bundle editor with the following settings:
#    Save: Current File
#    Input: None
#    Output: Show as Tool Tip
#    Activation: [Key Equivalent] ⌘S
#
# In your TextMate Project, edit "Project Information" by setting the following 2 vars:
#    RSYNC_LOCAL:  /Users/steve/dev/myproject   (top of project on your Mac)
#    RSYNC_REMOTE: steve@myremotebox.example.com:/home/steve/public_html/myproject
#
# NOTE - no trailing slashes above.
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
if (local.nil? || remote.nil?)
    exit
end

path = ENV["TM_FILEPATH"][local.length .. -1]

output = `rsync -vz -e 'ssh -ax' #{ENV['TM_FILEPATH']} #{remote}#{path}`

lines = output.split("\n")
puts "File Synchronized!"
puts lines[-2]

# output is something like:
#
#    sent 39 bytes  received 20 bytes  118.00 bytes/sec
#    total size is 1101  speedup is 18.66
