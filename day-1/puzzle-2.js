const values = require("./input.json");

function puzzle2 ({
  values
}) {
  return values.reduce(
    (sum, value) => {
      const numsDict = {
        one: 1,
        two: 2,
        three: 3,
        four: 4,
        five: 5,
        six: 6,
        seven: 7,
        eight: 8,
        nine: 9,
      }

      const numbersFound = [
        ...Object
        .keys(numsDict)
        .map(
          numText => value.matchAll(new RegExp(numText, "g"))
        )
        .reduce(
          (res, regRes) => [...res, ...regRes],
          []
        ),
        ...value.matchAll(/[0-9]/g)
      ].sort((a, b) => a["index"] - b["index"]);

      const sanitizedNumbers =  numbersFound
                                .map(
                                  numText => numText in numsDict ? numsDict[numText] : +numText
                                );

      if (!sanitizedNumbers.length) return sum;

      const numberForValue = +`${sanitizedNumbers[0]}${sanitizedNumbers[sanitizedNumbers.length - 1]}`

      return numberForValue + sum;
    },
    0
  );
}

// const testValues = [
// "two1nine",
// "eightwothree",
// "abcone2threexyz",
// "xtwone3four",
// "4nineeightseven2",
// "zoneight234",
// "7pqrstsixteen"
// ]

console.log(puzzle2({
  values
}));
