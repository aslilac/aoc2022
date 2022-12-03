import extra
import gleam/bit_string
import gleam/bool
import gleam/erlang/file
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/set
import gleam/string

const input_file = "./src/solutions/day3/input.txt"

fn compartmentalize(line) {
  let length = string.length(line)
  let comparment_size = length / 2
  let a =
    string.slice(line, 0, comparment_size)
    |> compartment_contents
  let b =
    string.slice(line, comparment_size, comparment_size)
    |> compartment_contents
  #(a, b)
}

fn compartment_contents(content) {
  content
  |> string.to_graphemes
  |> set.from_list
}

fn to_priority(item) {
  case bit_string.from_string(item) {
    <<code>> ->
      case code >= 97 {
        True -> code - 96
        False -> code - 38
      }
  }
}

pub fn main() {
  io.println("aoc 2022 day 3 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.split("\n")
  // remove empty lines
  |> list.filter(function.compose(string.is_empty, bool.negate))
  |> list.map(compartmentalize)
  |> list.map(fn(compartments) {
    set.intersection(compartments.0, compartments.1)
    |> set.to_list
    |> list.first
    |> extra.unwrap_forever
  })
  |> list.map(to_priority)
  |> int.sum()
  |> io.debug
}
