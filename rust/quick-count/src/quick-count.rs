extern crate quick_csv as csv;

fn main() {
    let args: Vec<String> = ::std::env::args().collect();
    let field_num = args[1].parse::<usize>().unwrap() - 1;
    let filename = &args[2];
    let rdr = csv::Csv::from_file(filename).unwrap();
    let mut sum = 0;

    for row in rdr.into_iter() {
        sum += row.columns()
		  .nth(field_num + 1).unwrap()
		  .parse::<i64>().unwrap();
    }

    println!("{}", sum);
}
