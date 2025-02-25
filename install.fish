#!/usr/bin/env fish

# Function: List available development commands
function list_dev_commands
    if not set -q MARKDOWN_RENDERER
        set MARKDOWN_RENDERER glow
    end
    $MARKDOWN_RENDERER $DEV_COMMAND_HELP
end

# Function: Load environment variables from a .env file
function spawn_environment_from_env
    set -l env_file $argv[1]
    if test -f $env_file
        for line in (string trim < $env_file)
            # Skip comments and empty lines
            if string match -q "#*" $line; or string match -q "" $line
                continue
            end

            # Split line by the first '='
            set -l key (string split "=" $line)[1]
            set -l value (string split -m1 "=" $line)[2..-1]

            # Reconstruct and clean value
            set -l value (string join "=" $value)
            set value (string trim -c "'" $value)
            set value (string trim -c '"' $value)

            # Export the variable
            set -x $key $value
        end
        fish
    else
        echo "❌ File $env_file does not exist."
        return 1
    end
end

# Function: List files and their contents using fd
function ls_files_and_contents
    set -l fd_command "fd $argv -x bash -c 'for file in \"\$@\"; do ls \"\$file\" | sed \"s/\$/:/\" && cat \"\$file\" && echo; done' bash"
    eval $fd_command
end

# Function: Temporarily enable ptrace debugging
function enable_debug_ptrace
    set -l original_value (sysctl -n kernel.yama.ptrace_scope)
    sudo sysctl kernel.yama.ptrace_scope=0
    fish
    echo "🔄 Reverting ptrace permissions..."
    sudo sysctl kernel.yama.ptrace_scope=$original_value
end

# Install `zd` function only if prerequisites exist
if type -q zoxide; and type -q fzf
    function zd
        zi $argv
        pwd
    end
    funcsave zd
else
    echo "⚠️  Skipping installation of 'zd' because 'zoxide' and/or 'fzf' is missing."
end

funcsave list_dev_commands
funcsave spawn_environment_from_env
funcsave ls_files_and_contents
funcsave enable_debug_ptrace

# Set paths
set commands_md (realpath commands.md)
set fish_config ~/.config/fish/conf.d/dev.fish

# Check if the Fish config file exists and prompt before overwriting
if test -e $fish_config
    echo "⚠️  The file '$fish_config' already exists."
    echo "❓ Do you want to replace it? (y/N): "
    read response

    if test (string lower -- $response) != y
        echo "❌ Operation canceled. The existing file was not modified."
        exit 1
    end

    echo "🔄 Overwriting config file '$fish_config'..."
else
    echo "💾 Writing new config file '$fish_config'..."
end

# Write the DEV_COMMAND_HELP variable
echo "set DEV_COMMAND_HELP \"$commands_md\"" >$fish_config

echo "✅ Installation complete!"
