import gleam/erlang/file
import gleam/io

const input_file = "./src/solutions/day1/input.txt"

pub fn main() {
  io.println("aoc 2022 day 1 answer:")
  assert Ok(text) = file.read(input_file)
  io.println(text)
}
