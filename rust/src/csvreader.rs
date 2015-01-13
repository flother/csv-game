extern crate csv;

use std::path::Path;

fn main() {
    let fp = &Path::new("/dev/stdin");
    let mut rdr = csv::Reader::from_file(fp).has_headers(false);
    let mut sum = 0;

    for row in rdr.decode() {
        let cols : Vec<String> = row.unwrap();
        sum += cols.len();
    }
    println!("{}", sum);
}
