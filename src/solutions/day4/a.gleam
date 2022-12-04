import extra
import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/string

const input_file = "./src/solutions/day4/input.txt"

pub type Range {
  Range(begins_at: Int, ends_at: Int)
}

fn from_string(it: String) {
  assert Ok(#(begins_at, ends_at)) = string.split_once(it, "-")
  Range(
    int.parse(begins_at)
    |> extra.unwrap_forever,
    int.parse(ends_at)
    |> extra.unwrap_forever,
  )
}

fn fully_overlapped(a: Range, b: Range) -> Bool {
  a.begins_at >= b.begins_at && a.ends_at <= b.ends_at || a.begins_at <= b.begins_at && a.ends_at >= b.ends_at
}

fn parse_range_pair(line) {
  assert Ok(#(part_a, part_b)) = string.split_once(line, ",")
  let range_a = from_string(part_a)
  let range_b = from_string(part_b)
  #(range_a, range_b)
}

pub fn main() {
  io.println("aoc 2022 day4 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(parse_range_pair)
  |> list.filter(fn(pair) { fully_overlapped(pair.0, pair.1) })
  |> list.length()
  |> io.debug
}
