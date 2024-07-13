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
  let [a, b] = key;
  
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

function shortestPath(source, target) {
  let recorder = {};
  let queue = addAllDirectionsOf(source, recorder);

  while (queue.length) {
    let first = queue.shift();
    let [child, parent] = first;

    let convertedChild = convertToKey(child);
    let convertedParent = convertToKey(parent);

    if (recorder[convertedChild]) continue;

    recorder[convertedChild] = convertedParent;
    // in javascript can't simply compare two array
    if (convertedChild == convertedParent) return recorder;

    queue = queue.concat(addAllDirectionsOf(child, recorder));
  }

  return recorder;
}

// console.log(shortestPath([5, 5], [0, 0]));

function track(source, target, recorder) {
  let result = [];
  let current = convertToKey(target);
  source = convertToKey(source);

  while (true) {
    result.unshift(current);

    if (current == source) return result;

    current = recorder[current];
  }
}

// let recorder = shortestPath([5,5], [0, 0]);
// console.log(track([5, 5], [0, 0], recorder));

function printPath(tracker) {
  let path = '';
  const last = tracker.length - 1;

  for (let i = 0; i < tracker.length; i++) {
    let arrow = '';
    for (let j = 0; j < (i + 1); j++) arrow += '>';

    path += (i == last ? ` ${tracker[i]}` : ` ${tracker[i]} ${arrow}`);
  }

  console.log(path);
}

// let recorder = shortestPath([5, 5], [0, 0]);
// let tracker = track([5, 5], [0, 0], recorder);

// printPath(tracker);

function printBoard(tracker) {
  const letters = '       A   B   C   D   E   F   G   H  ';
  const dashed = '     ---------------------------------';

  console.log(letters);
  console.log(dashed);

  for (let row = 0; row < 8; row++ ) {
    let line = `  ${8 - row}  |`;

    for (let col = 0; col < 8; col++) {
      line += tracker.includes(convertToKey([row, col])) ? ' \u265E |' : '   |';

      if (col == 7) line += `  ${8 - row}`;
    }

    console.log(line);
    console.log(dashed);
  }

  console.log(letters);
}

let recorder = shortestPath([5, 5], [0, 0]);
let tracker = track([5, 5], [0, 0], recorder);

printBoard(tracker);
printPath(tracker);