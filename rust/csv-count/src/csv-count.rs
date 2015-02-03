extern crate csv;

use std::path::Path;
use std::os;

fn main() {
    let args = os::args();
    let field = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let fp = &Path::new(filename);
    let mut rdr = csv::Reader::from_file(fp).has_headers(false);
    let mut sum = 0;

    for row in rdr.decode() {
        let cols : Vec<String> = row.unwrap();
        sum += cols[field].parse::<i64>().unwrap();
    }
    println!("{}", sum);
}
