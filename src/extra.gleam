import gleam/int

pub fn unwrap_forever(result: Result(a, b)) -> a {
  assert Ok(v) = result
  v
}

pub fn int_parse_unsafe(int: String) -> Int {
  int
  |> int.parse()
  |> unwrap_forever
}
