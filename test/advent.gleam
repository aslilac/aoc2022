import gleeunit/should
import solutions/day1/a as day1a
import solutions/day1/b as day1b

pub fn day1_test() {
  day1a.main()
  |> should.equal(72240)

  day1b.main()
  |> should.equal(210957)
}
