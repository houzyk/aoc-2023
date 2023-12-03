const input = require("./input.json");

const puzzle2 = ({ input }) => {
  const [ nbPosData, symPosData ] = [ /[0-9]+/g, /\*/g, ].map(reg => input.reduce(
                                    (data, str, line) => [...data, ...(
                                      [...str.matchAll(reg)]
                                      .map(search => ({ line, txt: search[0], pos: search["index"], }))
                                    )], [])
                                  );

  return symPosData.reduce(
    (sum, { line: symLine, pos: symPos }) => {
      const nbsNear = nbPosData.filter(({ line: nbLine, pos: nbPos, txt }) =>
                        ( nbLine === symLine ||
                          (!!(nbLine - 1) && symLine === (nbLine - 1)) ||
                          (!!(nbLine + 1) && symLine === (nbLine + 1))
                        ) &&
                        ((symPos <= (nbPos + txt.length)) && (symPos >= (nbPos - 1)))
                      ).map(nbData => +nbData["txt"]);

      return nbsNear.length === 2 ? nbsNear.reduce((pr, nb) => nb * pr, 1) + sum : sum;
    }
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

console.log(puzzle2({ input }));
