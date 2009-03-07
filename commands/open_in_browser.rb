#!/opt/local/bin/ruby -w
# 
# =========================================================
# * NOTE *
# your ruby is probably located in /usr/bin/ruby, so
# change the first line to #!/usr/bin/ruby -w
# =========================================================
#
# Map paths to web servers to open current file in default browser.
#
# TextMate Command Settings:
#     Save: Current File
#     Input: None
#     Output: Discard
#     Activation: (Key Equivalent) ⌘U
#     Scope Selector: text.html, source.css, source.php, source.js
#

# Map a file directly to a URL, or map directories to web servers.
map = {
  "/Users/steve/Sites/"                                         => "http://localhost/",
  "/Users/steve/dev/platform/Core/BPCore/ui/install_dialog/en/" => "http://localhost/gen/p/en-US/",
  "/Users/steve/dev/platform/Core/ConfigPanel/ui/en/"           => "http://localhost/gen/c/en-US/",
  "/Users/steve/dev/platform/Core/InstallAndUpdate/ui/"         => "http://localhost/gen/i/en-US/",
  "/Users/steve/dev/prod/htdocs/"                               => "http://prod/",
  "/Users/steve/dev/corp/htdocs/"                               => "http://corp/"
}

# open files with these extensions, for all else (css, js, ...) open directory
html = { ".html" => 1, ".php"  => 1 }

# full path to current file
fp = ENV["TM_FILEPATH"]

if (map.has_key?(fp))
  # There is a direct mapping.  That was easy.
  `open #{map[fp]}`  
else
  # Loop thru each key and find the match
  map.each_key do |key|
    if fp.index(key) == 0
      url = map[key]
      fn = fp[key.length..-1] # strip off map[key] from filepath
      ext = fn.match(/\.[a-z]+$/)[0]

      if (!html.has_key?(ext)) # not a "html" file, open directory (to show index.html, index.php)
        pos = fn.rindex("/")
        if (pos)
          fn = fn[0..fn.rindex("/")] # strip off file name, leave relative path
        else
          fn= "" # strip off file name, file is at top level
        end
      end
      `open #{url}#{fn}`
    end
  end
end