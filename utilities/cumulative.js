function cost (base, scale, num) {
    //let res = base * num + (scale * (num - 1));
    //let res = base * num + (scale * (num - 1));
    let res = base + (scale * (num - 1));
    console.log(`${res} = ${base} * ${num} + (${scale} * (${num}));`);
    return res;
}

console.log(cost(1,2,1));
console.log(cost(1,2,2));
console.log(cost(1,2,3));
console.log(cost(1,2,4));
/*
console.log(cost(5,5,3));
console.log(cost(3,5,2));
console.log(cost(3,5,3));*/
