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

struct ctx {
    int count;
    int col;
};

]]

local CSV_APPEND_NULL = 8

local libcsv = ffi.load("libcsv.so")

-------------------------------------------------------------

sum_field = tonumber(arg[1])

local function field_count(str, str_len, data)
    local ctx = ffi.cast("struct ctx*", data)
    local field = ffi.string(str, str_len)
    if ctx[0].col == sum_field then
        ctx[0].count = ctx[0].count + tonumber(field)
    end
    ctx[0].col = ctx[0].col + 1
end

local function reset_line(lineno, data)
    local ctx = ffi.cast("struct ctx*", data)
    ctx[0].col = 1

end

local READ_SZ = 1024 * 1024

local parser = ffi.new("struct csv_parser")
local ctx = ffi.new("struct ctx[1]")
ctx[0].count = 0
ctx[0].col = 1

libcsv.csv_init(parser, CSV_APPEND_NULL)

local fh = io.open(arg[2])
local buf = fh:read(READ_SZ)
while buf do
    libcsv.csv_parse(parser, buf, #buf, field_count, reset_line, ctx);
    buf = fh:read(READ_SZ)
end

print(ctx[0].count)
