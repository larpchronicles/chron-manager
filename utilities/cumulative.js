/**
 * ex: 3+5 purchased 4 times
 * 42 = 3 * 4 + (5 * ((4 - 1) ** 2 + 4-1) / 2)
 * 42 = 4(3) + 5(6)
 * @type {number}
 */
function calculateCumulativeCost (baseCost, scaleCost, numPurchases) {
    let res = baseCost * numPurchases + (scaleCost * ((numPurchases - 1) ** 2 + numPurchases -1) / 2 );
    console.log(`baseCost: ${baseCost}  scaleCost: ${scaleCost}  numPurchases:${numPurchases}`);
    console.log(`${res} = ${baseCost} * ${numPurchases} + (${scaleCost} * ((${numPurchases} - 1) ** 2 + ${numPurchases} -1) / 2)`);
    return res;
}

console.log(calculateCumulativeCost(3,5,1));
console.log(calculateCumulativeCost(3,5,2));
console.log(calculateCumulativeCost(3,5,3));
console.log(calculateCumulativeCost(3,5,4));
console.log(calculateCumulativeCost(3,5,5));
//3, 11, 24, 42
// 3, 11, 24


// (n^2 + n) / 2
// (n-1^2 + n-1) / 2

// n = 1: 3
//n=2: (3) + (3 + 5) = 3(2) + 5(1)          (2^2 + 2) / 2 = 3
//n=3: (3) + (3 + 5) + (3 + 5 + 5) = 3(3) + 5(3)      (3^2 + 3) / 2 = 6
//n=4: (3) + (3 + 5) + (3 + 5 + 5) + (3 + 5 + 5 + 5) = 3(4) + 5(6)
//n=5: (3) + (3 + 5) + (3 + 5 + 5) + (3 + 5 + 5 + 5) + (3 +5 +5 +5 +5) = 3(5) + 5(10)
//n=6: (3) + (3 + 5) + (3 + 5 + 5) + (3 + 5 + 5 + 5) + (3 +5 +5 +5 +5) + (3 + 5 + 5 + 5 + 5 + 5) = 3(6) + 5(15)
// = base * n +
/*console.log(cost(1,2,1));
console.log(cost(1,2,2));
console.log(cost(1,2,3));
console.log(cost(1,2,4));*/
/*
console.log(cost(5,5,3));
console.log(cost(3,5,2));
console.log(cost(3,5,3));*/
