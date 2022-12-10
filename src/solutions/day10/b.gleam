import extra
import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import gleam/string

const input_file = "./src/solutions/day10/input.txt"

pub type Instruction {
  Noop
  Addx(d: Int)
}

pub fn main() {
  io.println("aoc 2022 day10 answer:")
  assert Ok(input) = file.read(input_file)

  let states =
    input
    |> string.trim()
    |> string.split("\n")
    |> list.map(fn(instruction) {
      let [name, ..params] = string.split(instruction, " ")

      case name {
        "noop" -> Noop
        "addx" -> {
          assert Ok(d) = list.at(params, 0)
          assert Ok(d) = int.parse(d)
          Addx(d)
        }
      }
    })
    |> list.map_fold(
      1,
      fn(x, instruction) {
        case instruction {
          Noop -> #(x, [x])
          Addx(d) -> #(x + d, [x, x + d])
        }
      },
    )
    |> pair.second()
    |> list.flatten()

  let output =
    [1, ..states]
    |> extra.enumerate_list()
    |> list.map(fn(it) {
      let #(i, x) = it
      let i = i % 40
      case i >= x - 1 && i <= x + 1 {
        True -> "#"
        False -> "."
      }
    })
    |> list.sized_chunk(40)
    |> list.map(string.concat)
    |> list.take(6)

  output
  |> list.each(io.println)

  output
}
