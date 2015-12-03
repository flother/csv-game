extern crate quick_csv as csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let field_num = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let rdr = csv::Csv::from_file(filename).unwrap();

    let sum = rdr.into_iter()
                 .map(|r| r.unwrap().columns().unwrap()
                           .nth(field_num).unwrap().parse::<i64>().unwrap())
                 .fold(0i64, |c, n| c + n);

    println!("{}", sum);
}
