import gleeunit/should
import solutions/day1/a as day1a
import solutions/day1/b as day1b
import solutions/day2/a as day2a
import solutions/day2/b as day2b
import solutions/day3/a as day3a
import solutions/day3/b as day3b
import solutions/day4/a as day4a
import solutions/day4/b as day4b
// import solutions/day5/a as day5a
// import solutions/day5/b as day5b
import solutions/day10/a as day10a
import solutions/day10/b as day10b

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

pub fn day3_test() {
  day3a.main()
  |> should.equal(7817)

  day3b.main()
  |> should.equal(2444)
}

pub fn day4_test() {
  day4a.main()
  |> should.equal(464)

  day4b.main()
  |> should.equal(770)
}

// pub fn day5_test() {
//   day5a.main()
//   |> should.equal(0)

//   day5b.main()
//   |> should.equal(0)
// }

pub fn day10_test() {
  day10a.main()
  |> should.equal(17380)
  day10b.main()
  |> should.equal([
    "####..##...##..#..#.####.###..####..##..",
    "#....#..#.#..#.#..#....#.#..#.#....#..#.",
    "###..#....#....#..#...#..#..#.###..#....",
    "#....#.##.#....#..#..#...###..#....#....",
    "#....#..#.#..#.#..#.#....#.#..#....#..#.",
    "#.....###..##...##..####.#..#.####..##..",
  ])
}
