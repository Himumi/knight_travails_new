function convertToIndexes(key) {
  const letters = {
    a: 0, b: 1, c: 2, d: 3,
    e: 4, f: 5, g: 6, h: 7
  };

  const numbers = {
    1: 7, 2: 6, 3: 5, 4: 4,
    5: 3, 6: 2, 7: 1, 8: 0
  };

  let letter = letters[key[0]];
  let number = numbers[key[1]];

  if (letter != undefined && number != undefined) return [number, letter];

  return undefined;
}

// console.log(convertToIndexes("aj"));