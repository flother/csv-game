extern crate quick_csv as csv;

fn main() {
    let fpath = ::std::env::args().nth(1).unwrap();
    let rdr = csv::Csv::from_file(fpath).unwrap();
    let sum = rdr.into_iter().count();
    println!("{}", sum);
}
