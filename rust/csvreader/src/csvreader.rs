extern crate csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let filename = &args[1];
    let mut rdr = csv::Reader::from_file(filename).unwrap().has_headers(false);
    let mut sum = 0;

    while !rdr.done() {
        while let Some(_) = rdr.next_field().into_iter_result() {
            sum += 1;
        }
    }
    println!("{}", sum);
}
