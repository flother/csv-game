#![feature(plugin)]
#![plugin(peg_syntax_ext)]

use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;

peg! parser(r#"
#[pub]
record -> Vec<String>
    = field ** ","
field -> String
      = "\"" f:([^\"]* {match_str.to_string() })  "\"" { f }
      / f:([^,\n]* { match_str.to_string() }) { f }
"#);

fn main() {
    let fpath = ::std::env::args().nth(1).unwrap();
    let f = File::open(fpath).unwrap();
    let file = BufReader::new(&f);
    let mut sum = 0;
    for line in file.lines() {
        let l = line.unwrap();
        let rec = parser::record(&l).unwrap();
        sum += rec.len();
    }
    println!("{}", sum);
}

#[test]
fn test_hello() {
    assert_eq!(parser::record(r#"hello,","," ",world,"!""#).unwrap().len(), 5);
}
