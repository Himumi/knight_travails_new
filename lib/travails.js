function convertToIndexes(key) {
  const letters = {
    a: 0, b: 1, c: 2, d: 3,
    e: 4, f: 5, g: 6, h: 7
  };

  const numbers = {
    1: 7, 2: 6, 3: 5, 4: 4,
    5: 3, 6: 2, 7: 1, 8: 0
  };

  const letter = letters[key[0]];
  const number = numbers[key[1]];

  // to use (!= undefined) when involved with number,
  // (!!0) isn't worked at this context, cause 0 equal false
  if (letter != undefined && number != undefined) return [number, letter];

  return undefined;
}

// console.log(convertToIndexes("a8"));

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

  if (!!letter && !!number) return letter + number;

  return undefined;
}

// console.log(convertToKey([0, 0]));

function directionOf(key, path) {
  let a = key[0];
  let b = key[1];
  
  const paths = [
    [a-1, b-2], [a-2, b-1], [a-2, b+1], [a-1, b+2],
    [a+1, b+2], [a+2, b+1], [a+2, b-1], [a+1, b-2]
  ];

  const next = paths[path];

  for(const i of next) if (i < 0 || i > 7) return undefined;

  return next;
}

// console.log(directionOf([7, 0], 3));

function addAllDirectionsOf(source, recorder) {
  let result = [];

  for(let i = 0; i < 8; i++) {
    const next = directionOf(source, i);

    if (!!next && !recorder[convertToKey(next)]) result.push([next, source]);
  }

  return result;
}

// let b = {"d4" : "f3"};
// console.log(addAllDirectionsOf([0, 0], b));