import gleam/bool
import gleam/erlang/file
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/string

const input_file = "./src/solutions/day1/input.txt"

fn unwrap_forever(result: Result(a, b)) -> a {
  assert Ok(v) = result
  v
}

fn int_parse_unsafe(int: String) -> Int {
  int
  |> int.parse()
  |> unwrap_forever
}

pub fn main() {
  io.println("aoc 2022 day 1 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.split("\n\n")
  |> list.map(string.split(_, "\n"))
  |> list.map(list.filter(_, function.compose(string.is_empty, bool.negate)))
  |> list.map(list.map(_, int_parse_unsafe))
  |> list.map(int.sum)
  |> list.sort(int.compare)
  |> list.reverse()
  |> list.take(3)
  |> int.sum()
  |> io.debug
}
