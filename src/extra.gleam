import gleam/int
import gleam/list
import gleam/pair

pub fn unwrap_forever(result: Result(a, b)) -> a {
  assert Ok(v) = result
  v
}

pub fn int_parse_unsafe(int: String) -> Int {
  int
  |> int.parse()
  |> unwrap_forever
}

pub fn enumerate_list(stuffs: List(a)) -> List(#(Int, a)) {
  stuffs
  |> list.map_fold(0, fn(i, item) { #(i + 1, #(i, item)) })
  |> pair.second()
}
