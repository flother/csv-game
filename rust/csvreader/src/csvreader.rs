extern crate csv;

use std::os;
use std::path::Path;

fn main() {
    let args = os::args();
    let filename = &args[1];
    let fp = &Path::new(filename);
    let mut rdr = csv::Reader::from_file(fp).has_headers(false);
    let mut sum = 0;

    for row in rdr.decode() {
        let cols : Vec<String> = row.unwrap();
        sum += cols.len();
    }
    println!("{}", sum);
}
