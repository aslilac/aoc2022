import extra
import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/string

const input_file = "./src/solutions/day5/input.txt"

pub fn main() {
  io.println("aoc 2022 day5 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.trim()
  |> string.split("\n")
  |> io.debug
}
