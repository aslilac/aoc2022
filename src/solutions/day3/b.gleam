import extra
import gleam/bit_string
import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/set
import gleam/string

const input_file = "./src/solutions/day3/input.txt"

fn to_priority(item) {
  let <<code:int>> = bit_string.from_string(item)

  case code >= 97 {
    True -> code - 96
    False -> code - 38
  }
}

pub fn main() {
  io.println("aoc 2022 day 3 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.trim()
  |> string.split("\n")
  |> list.map(fn(content) {
    content
    |> string.to_graphemes
    |> set.from_list
  })
  |> list.sized_chunk(3)
  |> list.map(fn(group) {
    group
    |> list.reduce(set.intersection)
    |> extra.unwrap_forever
  })
  |> list.map(fn(overlap) {
    overlap
    |> set.to_list
    |> list.first
    |> extra.unwrap_forever
  })
  |> list.map(to_priority)
  |> int.sum()
  |> io.debug
}
