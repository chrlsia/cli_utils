// import read_stdin from cli_utils
use cli_utils::read_stdin;

fn main() {
    println!("Hello, world!");
    let input = read_stdin();
    println!("You entered: {}", input);
}
