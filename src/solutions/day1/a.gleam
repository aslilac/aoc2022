import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/string

const input_file = "./src/solutions/day1/input.txt"

fn unwrap_forever(result: Result(a, b)) -> a {
  assert Ok(v) = result
  v
}

pub fn main() {
  io.println("aoc 2022 day 1 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.split("\n")
  |> list.map(string.trim)
  |> list.chunk(string.is_empty)
  |> list.filter(fn(l) { l != [""] })
  |> list.map(list.map(_, fn(it) {
    int.parse(it)
    |> unwrap_forever
  }))
  |> list.map(list.fold(_, 0, int.add))
  |> list.fold(0, int.max)
  |> io.debug
}
