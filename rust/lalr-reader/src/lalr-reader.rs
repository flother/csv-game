pub mod csv;

use std::io::BufReader;
use std::io::BufRead;
use std::fs::File;

fn main() {
    let fpath = ::std::env::args().nth(1).unwrap();
    let f = File::open(fpath).unwrap();
    let file = BufReader::new(&f);
    let mut sum = 0;
    for line in file.lines() {
        let l = line.unwrap();
        let rec = csv::parse_Record(&l).unwrap();
        sum += rec.len();
    }
    println!("{}", sum);
}
