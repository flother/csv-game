extern crate quick_csv as csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let field_num = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let rdr = csv::Csv::from_file(filename).unwrap();

    let sum = rdr.into_iter()
                 .map(|r| r.unwrap().bytes_columns().nth(field_num)
                      .and_then(|c| ::std::str::from_utf8(c).ok())
                      .and_then(|s| s.parse::<i64>().ok()).unwrap())
                 .fold(0i64, |c, n| c + n);

    println!("{}", sum);
}
