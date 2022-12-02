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

fn translate(move: String) -> Result(Attack, Nil) {
  case move {
    "A" | "X" -> Ok(Rock)
    "B" | "Y" -> Ok(Paper)
    "C" | "Z" -> Ok(Scissors)
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

pub fn main() {
  io.println("aoc 2022 day 2 answer:")
  assert Ok(input) = file.read(input_file)

  input
  |> string.split("\n")
  // remove empty lines
  |> list.filter(function.compose(string.is_empty, bool.negate))
  |> list.map(fn(it) {
    let #(them, me) =
      string.split_once(it, " ")
      |> extra.unwrap_forever

    #(
      translate(them)
      |> extra.unwrap_forever,
      translate(me)
      |> extra.unwrap_forever,
    )
  })
  |> list.map(fn(pairing) {
    let #(them, me) = pairing
    let attack_score = score(me)
    let outcome = compare(me, them)
    let win_score = compare_score(outcome)

    attack_score + win_score
  })
  |> int.sum()
  |> io.debug
}
