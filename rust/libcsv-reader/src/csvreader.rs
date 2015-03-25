#![feature(libc)]
#![feature(os)]
#![feature(old_io)]
#![feature(old_path)]
#![feature(core)]

extern crate libc;

use std::os;
use std::mem;
use std::ptr;
use std::num::NumCast;
use std::old_path::posix::Path;
use std::old_io::{BufferedReader, Reader, File};
use libc::{c_int, size_t, c_void};

extern "C" fn field_count(str : *mut c_void, str_len : size_t, data : *mut i64) {
    unsafe {
        *data = *data + 1;
    }
}

#[repr(C)]
struct CSVParser {
  pstate: i64,
  quoted: i64,
  spaces: size_t,
  entry_buf: *mut u8,
  entry_po: size_t,
  entry_size: size_t,
  status: i64,    
  opts: u8, // was "options"
  quote_char: u8,
  delim_char: u8,
  is_space: fn(u8)-> i64,
  is_term: fn(u8) -> i64,
  blk_size: size_t,
  malloc_func: fn(size_t) -> *mut c_void,
  relloc_func: fn(*mut c_void, size_t) -> *mut c_void,
  free_func: fn(*mut c_void),
}

impl CSVParser {
    fn new() -> CSVParser{
        unsafe {
            return mem::zeroed();
        }
    }
}

#[link(name = "csv")]
extern {
    fn csv_init(parser : *mut CSVParser, opt: u8) -> i64;
    fn csv_parse(parser: *mut CSVParser, buf: *mut u8, buflen : size_t, 
        cb: extern fn(*mut c_void, size_t, *mut i64), 
        cb2: *const c_void, //cb2: fn(i64, *mut c_void), 
        data: *mut i64) -> size_t;
    fn csv_free(parser: *mut CSVParser);
}

fn main() {
    let CSV_APPEND_NULL = 8;
    const READ_SZ : usize = 1024 * 1024;

    let args = os::args();
    if args.len() < 2 {
        println!("Usage: csvreader <csv-file>");
        return;
    }
    let filename = &args[1];
    let path = Path::new(filename);
    let mut rdr = BufferedReader::new(File::open(&path));

    let mut parser = CSVParser::new();
    unsafe { csv_init(&mut parser, CSV_APPEND_NULL); };

    let mut buf = [0; READ_SZ];
    let mut sum = 0;
    while true {
        match rdr.read(&mut buf) {
            Ok(nread) => {
                let pbuf = buf.as_mut_ptr();
                unsafe {
                    csv_parse(&mut parser, 
                          pbuf, 
                          NumCast::from(READ_SZ).unwrap(), 
                          field_count, 
                          ptr::null::<c_void>(), 
                          &mut sum);
                };
            },
            Err(e) => break,
        }
    }
    unsafe { csv_free(&mut parser); };
    println!("{}", sum);
}
