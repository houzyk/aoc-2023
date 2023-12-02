const input = require("./input.json");

const puzzle1 = ({
  input,
  nbRed   = 12,
  nbGreen = 13,
  nbBlue  = 14,
}) => (
  Object.keys(input).reduce(
    (sum, gameID) =>
      [
        { colorReg: /[0-9]+ red/g,    colorMax: nbRed },
        { colorReg: /[0-9]+ green/g,  colorMax: nbGreen },
        { colorReg: /[0-9]+ blue/g,   colorMax: nbBlue },
      ]
      .reduce(
        (comp, { colorReg, colorMax }) =>
          input[gameID]
          .match(colorReg)
          .map(stat => +stat.replace(/[^0-9]/g, ''))
          .some(statNum => statNum > colorMax)
          || comp
        , false
      ) ? sum : +gameID.replace(/[^0-9]/g, '') + sum
    , 0
  )
);

const testInput = {
  "Game 1" : "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
  "Game 2" : "1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
  "Game 3" : "8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
  "Game 4" : "1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
  "Game 5" : "6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
}

console.log(puzzle1({ input }));
