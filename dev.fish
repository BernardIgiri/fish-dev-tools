function list_dev_commands
    echo "list_dev_commands - Shows list of functions"
    echo "spawn_environment_from_env - Takes an .env file and spawns a new fish shell terminal with the .env variables loaded"
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
