use std::io::Read;
use std::fs::File;

mod parser {
    include!(concat!(env!("OUT_DIR"), "/csv.rs"));
}

fn main() {
    let fpath = ::std::env::args().nth(1).unwrap();
    let mut f = File::open(fpath).unwrap();
    let mut text = String::new();
    f.read_to_string(&mut text).unwrap();
    let sum = parser::file(&text).unwrap();
    println!("{}", sum);
}

#[test]
fn test_hello() {
    assert_eq!(parser::record(r#"hello,","," ",world,"!""#).unwrap(), 5);
    assert_eq!(parser::file(r#"hello,","," ",world,"!"
hello,","," ",world,"!"
"#).unwrap(), 10);
}
