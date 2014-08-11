#!/usr/bin/env luajit

local ffi = require"ffi"

ffi.cdef[[

struct csv_parser {
  int pstate;         /* Parser state */
  int quoted;         /* Is the current field a quoted field? */
  size_t spaces;      /* Number of continious spaces after quote or in a non-quoted field */
  unsigned char * entry_buf;   /* Entry buffer */
  size_t entry_pos;   /* Current position in entry_buf (and current size of entry) */
  size_t entry_size;  /* Size of entry buffer */
  int status;         /* Operation status */
  unsigned char options;
  unsigned char quote_char;
  unsigned char delim_char;
  int (*is_space)(unsigned char);
  int (*is_term)(unsigned char);
  size_t blk_size;
  void *(*malloc_func)(size_t);
  void *(*realloc_func)(void *, size_t);
  void (*free_func)(void *);
};

int csv_init(struct csv_parser *p, unsigned char options);
size_t csv_parse(struct csv_parser *p, const void *s, size_t len, void (*cb1)(void *, size_t, void *), void (*cb2)(int, void *), void *data);
]]

local CSV_APPEND_NULL = 8

local libcsv = ffi.load("libcsv.so")

-------------------------------------------------------------

local function field_count(str, str_len, data)
    local count = ffi.cast("int *", data)
    count[0] = count[0] + 1
end

local READ_SZ = 1024 * 1024

local parser = ffi.new("struct csv_parser")
local count = ffi.new("int[1]")

libcsv.csv_init(parser, CSV_APPEND_NULL)

local buf = io.stdin:read(READ_SZ)
while buf do
    libcsv.csv_parse(parser, buf, #buf, field_count, nil, count);
    buf = io.stdin:read(READ_SZ)
end

print(count[0])
