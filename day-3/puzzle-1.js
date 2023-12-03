const input = require("./input.json");

const puzzle1 = ({ input }) => {
  const [ nbPosData, symPosData ] = [ /[0-9]+/g, /[^0-9,\.]/g, ].map(reg => input.reduce(
                                      (data, str, line) => [...data, ...(
                                        [...str.matchAll(reg)]
                                        .map(search => ({ line, txt: search[0], pos: search["index"], }))
                                      )], [])
                                    );

  return nbPosData.reduce(
    (sum, { line: nbLine, pos: nbPos, txt: nb }) =>
      !!symPosData.find(({ line: symLine, pos: symPos }) =>
        ( symLine === nbLine ||
          (!!(nbLine - 1) && symLine === (nbLine - 1)) ||
          (!!(nbLine + 1) && symLine === (nbLine + 1))
        ) &&
        (symPos <= ((nbPos + (nb.length - 1)) + 1) && symPos >= (nbPos - 1))
      ) ? sum + +nb : sum
    , 0
  );
}

// const testInput = [
//   "467..114..",
//   "...*......",
//   "..35..633.",
//   "......#...",
//   "617*......",
//   ".....+.58.",
//   "..592.....",
//   "......755.",
//   "...$.*....",
//   ".664.598..",
// ]

console.log(puzzle1({ input }));
