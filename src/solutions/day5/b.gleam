import extra
import gleam/bool
import gleam/erlang/file
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam/result

const input_file = "./src/solutions/day5/input.txt"

pub fn main() {
  io.println("aoc 2022 day5 answer:")
  assert Ok(input) = file.read(input_file)

  assert Ok(#(inventory, moves)) = string.split_once(input, "\n\n")

  let [labels, ..contents] =
    string.split(inventory, "\n")
    |> list.reverse

  let stack_count =
    string.split(labels, " ")
    |> list.filter(function.compose(string.is_empty, bool.negate))
    |> list.last()
    |> extra.unwrap_forever()
    |> int.parse()
    |> extra.unwrap_forever()

  let max_stack_height = list.length(contents)

  let initial_state =
    list.range(0, stack_count - 1)
    |> list.map(fn(x) {
      list.range(0, max_stack_height - 1)
      |> list.map(fn(y) {
        contents
        |> list.at(y)
        |> extra.unwrap_forever()
        |> string.to_graphemes()
        |> list.at(x * 4 + 1)
        |> result.unwrap(" ")
      })
      |> list.filter(fn(c) { c != " " })
    })

  moves
  |> string.trim()
  |> string.split("\n")
  |> list.fold(
    initial_state,
    fn(state, move) {
      let parts = string.split(move, " ")
      case parts {
        ["move", count, "from", from, "to", to] -> {
          assert Ok(count) = int.parse(count)
          let from_index =
            from
            |> int.parse
            |> extra.unwrap_forever
            |> int.subtract(1)
          let to_index =
            to
            |> int.parse
            |> extra.unwrap_forever
            |> int.subtract(1)
          assert Ok(from) = list.at(state, from_index)
          assert Ok(to) = list.at(state, to_index)
          let #(remaining, moving) = list.split(from, list.length(from) - count)
          state
          |> extra.set_at(from_index, remaining)
          |> extra.set_at(to_index, list.append(to, moving))
        }
        _ -> state
      }
    },
  )
  |> list.map(fn(it) {
    it
    |> list.last()
    |> extra.unwrap_forever()
  })
  |> string.concat()
  |> io.debug
}
