const values = require("./input.json");

function puzzle1 ({
  values
}) {
  return values.reduce(
    (sum, value) => {
      const numbersFound = value.match(/[0-9]/gi);

      if (!numbersFound.length) return sum;

      const numberForValue = +`${numbersFound[0]}${numbersFound[numbersFound.length - 1]}`;

      return numberForValue + sum;
    },
    0
  );
}

// const testValues = [
//   "1abc2",
//   "pqr3stu8vwx",
//   "a1b2c3d4e5f",
//   "treb7uchet",
// ]

console.log(puzzle1({
  values
}));
