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

function convertToKey(index) {
  if (index.length > 2) return undefined;

  const letters = {
    0 : 'a', 1 : 'b', 2 : 'c', 3 : 'd',
    4 : 'e', 5 : 'f', 6 : 'g', 7 : 'h'
  }

  const numbers = {
    0 : '8', 1 : '7', 2 : '6', 3 : '5',
    4 : '4', 5 : '3', 6 : '2', 7 : '1'
  }

  const number = numbers[index[0]];
  const letter = letters[index[1]];

  if (letter != undefined && number != undefined) return letter + number;

  return undefined;
}

// console.log(convertToKey([0, 0, 0]));