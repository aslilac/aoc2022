import extra
import gleam/bool
import gleam/erlang/file
import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/order.{Eq, Gt, Lt, Order}
import gleam/string

const input_file = "./src/solutions/day2/input.txt"

pub type Attack {
  Rock
  Paper
  Scissors
}

fn score(for attack: Attack) {
  case attack {
    Rock -> 1
    Paper -> 2
    Scissors -> 3
  }
}

fn translate_attack(move: String) -> Result(Attack, Nil) {
  case move {
    "A" -> Ok(Rock)
    "B" -> Ok(Paper)
    "C" -> Ok(Scissors)
    _ -> Error(Nil)
  }
}

fn translate_outcome(outcome: String) -> Result(Order, Nil) {
  case outcome {
    "X" -> Ok(Lt)
    "Y" -> Ok(Eq)
    "Z" -> Ok(Gt)
    _ -> Error(Nil)
  }
}

fn compare(of me: Attack, over opponent: Attack) {
  case #(me, opponent) {
    #(Rock, Scissors) | #(Scissors, Paper) | #(Paper, Rock) -> Gt
    _ if me == opponent -> Eq
    _ -> Lt
  }
}

fn compare_score(outcome: Order) {
  case outcome {
    Lt -> 0
    Eq -> 3
    Gt -> 6
  }
}

fn attack_from(opponent: Attack, outcome: Order) -> Result(Attack, Nil) {
  case #(opponent, outcome) {
    #(_, Eq) -> Ok(opponent)
    #(Paper, Lt) -> Ok(Rock)
    #(Scissors, Gt) -> Ok(Rock)
    #(Scissors, Lt) -> Ok(Paper)
    #(Rock, Gt) -> Ok(Paper)
    #(Rock, Lt) -> Ok(Scissors)
    #(Paper, Gt) -> Ok(Scissors)
    _ -> Error(Nil)
  }
}

fn decode_line(it) {
  let #(them, me) =
    string.split_once(it, " ")
    |> extra.unwrap_forever

  #(
    translate_attack(them)
    |> extra.unwrap_forever,
    translate_outcome(me)
    |> extra.unwrap_forever,
  )
}

fn score_game(pairing) {
  let #(them, outcome) = pairing
  let me =
    attack_from(them, outcome)
    |> extra.unwrap_forever
  let attack_score = score(me)
  let outcome = compare(me, them)
  let win_score = compare_score(outcome)

  attack_score + win_score
}

pub fn main() {
  io.println("aoc 2022 day 2 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.split("\n")
  |> list.filter(function.compose(string.is_empty, bool.negate))
  |> list.map(decode_line)
  |> list.map(score_game)
  |> int.sum()
  |> io.debug
}
