# Commands

## list_dev_commands

Shows list of functions.

**Usage:** `list_dev_commands`

## spawn_environment_from_env

Takes an .env file and spawns a new fish shell terminal with the .env variables loaded

**Usage:** `spawn_environment_from_env app.env`

## ls_files_and_contents

Takes an series of string params to pass to fd and returns the names of the files, a colon, and their contents.

**Usage:** `ls_files_and_contents '-g "*rs"' 'src/'`

**Output:**

```
src/main.rs:
fn main() {
    println!("Hello World!");
}

```

## enable_debug_ptrace

Creates a fish shell with ptrace set to allow process attachement for debugging. This is set globally. This feature is disabled when when you exit the new shell.

## enable_perf_testing

Creates a fish shell with performance event access enabled for kernel profiling by users for debugging. This is set globally. This feature is disabled when when you exit the new shell.

**Usage:** `enable_debug_ptrace`

## zd

Calls zd with params and then runs pwd afterwards.

**Usage:** `zd [some/folder]`

function enable_perf_testing
    set -l original_value (sysctl -n kernel.perf_event_paranoid)
    sudo sysctl kernel.perf_event_paranoid=1
    fish
    echo "🔄 Reverting perf event permissions..."
    sudo sysctl kernel.perf_event_paranoid=$original_value
end

