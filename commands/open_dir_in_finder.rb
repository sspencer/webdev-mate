#!/opt/local/bin/ruby -w
# =========================================================
# * NOTE *
# your ruby is probably located in /usr/bin/ruby, so
# change the first line to #!/usr/bin/ruby -w
# =========================================================
#
# This is an easy but useful one.  Open the current directory
# in finder.  I use this when I have to drag+drop images
# to the current directory.
#
# Create a command in TextMate's bundle editor with the following settings:
#    Save: Nothing
#    Input: None
#    Output: Discard
#    Activation: [Key Equivalent] ⇧⌘O (that's letter "o")
#
`open .`
