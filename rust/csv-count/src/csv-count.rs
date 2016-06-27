extern crate csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let field_num = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let mut rdr = csv::Reader::from_file(filename).unwrap().has_headers(false);
    let mut sum = 0;

    let mut col = 0;
    loop {
        match rdr.next_bytes() {
            csv::NextField::Data(field) => {
                if col == field_num {
                    let field_str = ::std::str::from_utf8(field).unwrap();
                    sum += field_str.parse::<i64>().unwrap();
                }
                col += 1;
            }
            csv::NextField::EndOfRecord => { col = 0; }
            csv::NextField::EndOfCsv => break,
            csv::NextField::Error(err) => panic!("{}", err),
        }
    }
    println!("{}", sum);
}
