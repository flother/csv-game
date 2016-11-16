extern crate csv_parser;
fn main() {
    let fpath = ::std::env::args().nth(1).unwrap();
    let mut sum = 0;
    if let Ok(parsed_csv) = csv_parser::parse_csv_from_file(&fpath) {
        for record in parsed_csv.iter() {
            sum += record.len();
        }
    }
    println!("{}", sum);
}
