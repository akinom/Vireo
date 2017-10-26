if ($?prompt) then                      # if this is an interactive shell
    set path = (~/bin $path)
    set ignoreeof                   # don't use CtrlD to exit shell
    set notify                  # notify when background jobs complete
    set filec                       # press ESC to complete filenames

    set autoexpand
    set autolist

    set history=300                     # remember last 300 commands
    alias h 'history 25'
    alias hl 'history'

    alias l. 'ls -d .* --color auto'
    alias ls 'ls  -F --color=auto'

    alias cp 'cp -i'
    alias mv 'mv -i'
    alias rm 'rm -i'
#   unalias rm                      # then rm wouldn't confirm

    alias whence '/usr/bin/which -a'

    alias ff  foreach f 

    alias j   jobs

    alias pd pushd                      # pd same as pushd
    alias pop popd                      # pop same as popd
    alias pl 'dirs -l -v' 

    alias gitlog "git log '--pretty=%h %cn %s'"
    alias gitqulog "git log --abbrev-commit '--pretty=%h %cn %s' --graph"
    alias gitbrlog git log --merges
    alias gitnffmerge   git merge --no-ff

    alias cwdcmd  'set prompt = "%{\033]0;${HOST}:%n %~\007%}%n `gitinfo` %c1%# %BA%b> "'
    set prompt = "%{\033]0;${HOST}:%n %~\007%}%n `gitinfo` %c1%# %BA%b> " 

endif

setenv JAVA_HOME  /usr/lib/jvm/java-1.7.0-openjdk.x86_64
