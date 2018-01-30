# ~/.cshrc - default .cshrc file for all architectures.
################################################################
## Please do not change the following few lines unless you're ##
## sure you know what you're doing.                           ##
################################################################

################################################################
if ($?prompt) then			# if this is an interactive shell

    set ignoreeof                   # don't use CtrlD to exit shell
    set notify			# notify when background jobs complete
    set filec			# press ESC to complete filenames

    set autoexpand
    set autolist


    set history=300			# remember last 100 commands
    alias h 'history 25'
    alias hl 'history'

    alias ls 'ls  -F --color=auto'

    alias cp 'cp -i'
    alias mv 'mv -i'
    alias rm 'rm -i'

    alias whence '/usr/bin/which -a'

    alias ff  foreach f 

    alias j   jobs

    alias pd pushd			# pd same as pushd
    alias pop popd			# pop same as popd
    alias pl 'dirs -l -v' 

    alias gitlog "git log '--pretty=%h %cn %s'"
    alias gitqulog "git log --abbrev-commit '--pretty=%h %cn %s' --graph"
    alias gitbrlog git log --merges 
    alias gitnffmerge   git merge --no-ff


    alias precmd 'set cgb=`gitinfo`'
    set prompt = '[%n@%m %c]$ '
    set prompt = '%n@%m [%$cgb]%c> '
    set prompt = '%{\033]0;%n@%m %~\007%}%B%n@%m: %$cgb %c1> '
endif

set path = (  . ~/bin $path )

umask 0007
