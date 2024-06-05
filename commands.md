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

Creates a fish shell with ptrace set to allow process attachement for debugging, and disables this when you exit.

**Usage:** `enable_debug_ptrace`