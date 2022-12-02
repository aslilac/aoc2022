import gleeunit/should
import solutions/day1/a as day1a
import solutions/day1/b as day1b
import solutions/day2/a as day2a
import solutions/day2/b as day2b

pub fn day1_test() {
  day1a.main()
  |> should.equal(72240)

  day1b.main()
  |> should.equal(210957)
}

pub fn day2_test() {
  day2a.main()
  |> should.equal(9177)

  day2b.main()
  |> should.equal(12111)
}
