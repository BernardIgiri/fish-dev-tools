function list_dev_commands
    if not set -q MARKDOWN_RENDERER
        set MARKDOWN_RENDERER "glow"
    end
    $MARKDOWN_RENDERER $DEV_COMMAND_HELP
end

function spawn_environment_from_env
    set -l env_file $argv[1]
    if test -f $env_file
        for line in (cat $env_file | string trim)
            # Skip comments and empty lines
            if string match -q "#*" $line
                continue
            end
            if string match -q "" $line
                continue
            end

            # Split line by the first '='
            set -l key (string split "=" $line)[1]
            set -l value (string split -m1 "=" $line)[2..-1]

            # Join value back together in case it was split incorrectly
            set -l value (string join "=" $value)

            # Remove quotes if present
            set value (string trim -c "'" $value)
            set value (string trim -c '"' $value)

            # Export the variable
            set -x $key $value
        end
        fish
    else
        echo "File $env_file does not exist."
    end
end

function ls_files_and_contents
    set -l fd_command "fd $argv -x bash -c 'for file in \"\$@\"; do ls \"\$file\" | sed \"s/\$/:/\" && cat \"\$file\" && echo; done' bash"
    eval $fd_command
end

function enable_debug_ptrace
    set -l original_value (sysctl -n kernel.yama.ptrace_scope)
    sudo sysctl kernel.yama.ptrace_scope=0
    fish
    echo "Reverting ptrace permissions..."
    sudo sysctl kernel.yama.ptrace_scope=$original_value
end