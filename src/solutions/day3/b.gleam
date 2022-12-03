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
  case bit_string.from_string(item) {
    <<code>> ->
      case code >= 97 {
        True -> code - 96
        False -> code - 38
      }
  }
}

fn enumerate(items: List(a)) -> List(#(a, Int)) {
  let result =
    items
    |> list.map_fold(0, fn(i, it) { #(i + 1, #(it, i)) })

  result.1
}

fn deenumerate(items: List(#(a, Int))) -> List(a) {
  items
  |> list.map(fn(it) { it.0 })
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
  |> enumerate
  |> list.chunk(fn(it) {
    let i = it.1
    i / 3
  })
  |> list.map(deenumerate)
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
