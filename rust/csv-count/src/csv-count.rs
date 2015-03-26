extern crate csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let field_num = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let mut rdr = csv::Reader::from_file(filename).unwrap().has_headers(false);
    let mut sum = 0;

    while !rdr.done() {
        let mut col = 0;
        while let Some(field) = rdr.next_field().into_iter_result() {
            if col == field_num {
                let field_str = String::from_utf8_lossy(field.unwrap());
                sum += field_str.parse::<i64>().unwrap();
            }
            col += 1;
        }
    }
    println!("{}", sum);
}
