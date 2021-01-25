// Sourced from https://www.fantasynamegenerators.com/scripts/spiderfolkNames.js?r
// piss off all the spider players with this one neat trick
// node spidernames.js > ../../strings/names/spider-first.txt
// node spidernames.js > ../../strings/names/spider-last.txt
//jshint esversion: 6
const nm1 = ["", "", "", "c", "ch", "k", "kh", "kr", "l", "n", "q", "qh", "qr", "r", "rh", "s", "sr", "sz", "x", "y", "z", "zh", "zr"];
const nm2 = ["a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "aa", "ai", "ee", "ia", "ou"];
const nm3 = ["c", "c", "ch", "k", "k", "kk", "kr", "kz", "lr", "lz", "nch", "nq", "nr", "nt", "q", "q", "qr", "qt", "qz", "r", "r", "rk", "rz", "rt", "rr", "rn", "s", "s", "ss", "sr", "sn", "v", "v", "vr", "x", "z", "x", "z", "zr", "zs", "k'r", "k's", "k'z", "l'z", "n'q", "q'z", "q't", "s't", "rk'", "x'"];
const nm4 = ["a", "e", "i", "o", "u", "a", "i", "o", "u", "a", "i", "a", "e", "i", "o", "u", "a", "i", "o", "u", "a", "i", "ee", "ie"];
const nm5 = ["c", "ch", "k", "q", "r", "rr", "t", "v", "z"];
const nm6 = ["", "b", "d", "q", "r", "s", "t", "x"];

const nm7 = ["", "", "ch", "h", "kh", "khr", "kl", "l", "lh", "n", "q", "qh", "r", "rh", "s", "sh", "shr", "sz", "y", "z", "zh"];
const nm8 = ["a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "ai", "ee", "ei", "ie", "ia"];
const nm9 = ["c", "ch", "c", "k", "k", "kk", "kn", "l", "ll", "l", "q", "ln", "lsh", "nch", "nq", "nt", "q", "qsh", "r", "s", "r", "rz", "rt", "rh", "rr", "rn", "s", "ss", "shr", "sh", "sh", "sn", "th", "v", "z", "v", "vh", "xh", "z", "zh", "zs", "k's", "k'th", "k'z", "l'sh", "n'q", "q'sh", "sh't", "th'"];
const nm10 = ["c", "ch", "l", "ll", "q", "r", "rh", "sh", "th", "v", "zh"];
const nm11 = ["", "", "", "", "", "", "d", "h", "l", "r", "s", "sh", "th"];

const nm12 = ["", "", "c", "ch", "kh", "l", "n", "q", "qh", "r", "rh", "s", "sz", "y", "z", "zh"];
const nm13 = ["a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "a", "e", "i", "a", "e", "i", "o", "ai", "ee", "ia"];
const nm14 = ["c", "c", "k", "ch", "k", "kk", "ll", "lr", "nch", "nq", "nt", "ll", "q", "q", "qr", "r", "r", "s", "v", "z", "rz", "rt", "rr", "rn", "s", "ss", "sn", "v", "z", "zs", "k's", "k'z", "n'q", "q'r", "r'", "s't", "t'"];
const nm15 = ["c", "ch", "q", "r", "s", "v", "z"];
const nm16 = ["", "", "d", "h", "l", "q", "r", "s"];

function nameMas() {
    let result = '';
	nTp = Math.random() * 6 | 0;
	rnd = Math.random() * nm1.length | 0;
	rnd2 = Math.random() * nm2.length | 0;
	rnd3 = Math.random() * nm6.length | 0;
	rnd4 = Math.random() * nm3.length | 0;
	rnd5 = Math.random() * nm4.length | 0;
	while (nm3[rnd4] === nm1[rnd] || nm3[rnd4] === nm6[rnd3]) {
		rnd4 = Math.random() * nm3.length | 0;
	}
	if (nTp < 4) {
		result = nm1[rnd] + nm2[rnd2] + nm3[rnd4] + nm4[rnd5] + nm6[rnd3];
	} else {
		rnd6 = Math.random() * nm2.length | 0;
		rnd7 = Math.random() * nm5.length | 0;
		while (nm5[rnd7] === nm3[rnd4] || nm5[rnd7] === nm6[rnd3]) {
			rnd7 = Math.random() * nm5.length | 0;
		}
		if (nTp === 4) {
			result = nm1[rnd] + nm2[rnd2] + nm3[rnd4] + nm4[rnd5] + nm5[rnd7] + nm2[rnd6] + nm6[rnd3];
		} else {
			result = nm1[rnd] + nm2[rnd2] + nm5[rnd7] + nm4[rnd5] + nm3[rnd4] + nm2[rnd6] + nm6[rnd3];
		}
	}
	return result.substr(0, 1).toLocaleUpperCase() + result.substr(1);
}

function nameFem() {
    let result = '';
	nTp = Math.random() * 6 | 0;
	rnd = Math.random() * nm7.length | 0;
	rnd2 = Math.random() * nm8.length | 0;
	rnd3 = Math.random() * nm11.length | 0;
	rnd4 = Math.random() * nm9.length | 0;
	rnd5 = Math.random() * nm4.length | 0;
	while (nm9[rnd4] === nm7[rnd] || nm9[rnd4] === nm11[rnd3]) {
		rnd4 = Math.random() * nm9.length | 0;
	}
	if (nTp < 4) {
		result = nm7[rnd] + nm8[rnd2] + nm9[rnd4] + nm4[rnd5] + nm11[rnd3];
	} else {
		rnd6 = Math.random() * nm8.length | 0;
		rnd7 = Math.random() * nm10.length | 0;
		while (nm10[rnd7] === nm9[rnd4] || nm10[rnd7] === nm11[rnd3]) {
			rnd7 = Math.random() * nm10.length | 0;
		}
		if (nTp === 4) {
			result = nm7[rnd] + nm8[rnd2] + nm9[rnd4] + nm4[rnd5] + nm10[rnd7] + nm8[rnd6] + nm11[rnd3];
		} else {
			result = nm7[rnd] + nm8[rnd2] + nm10[rnd7] + nm4[rnd5] + nm9[rnd4] + nm8[rnd6] + nm11[rnd3];
		}
	}
	return result.substr(0, 1).toLocaleUpperCase() + result.substr(1);
}

function nameNeut() {
    let result = '';
	nTp = Math.random() * 6 | 0;
	rnd = Math.random() * nm12.length | 0;
	rnd2 = Math.random() * nm13.length | 0;
	rnd3 = Math.random() * nm16.length | 0;
	rnd4 = Math.random() * nm14.length | 0;
	rnd5 = Math.random() * nm4.length | 0;
	while (nm14[rnd4] === nm12[rnd] || nm14[rnd4] === nm16[rnd3]) {
		rnd4 = Math.random() * nm14.length | 0;
	}
	if (nTp < 4) {
		result = nm12[rnd] + nm13[rnd2] + nm14[rnd4] + nm4[rnd5] + nm16[rnd3];
	} else {
		rnd6 = Math.random() * nm13.length | 0;
		rnd7 = Math.random() * nm15.length | 0;
		while (nm15[rnd7] === nm14[rnd4] || nm15[rnd7] === nm16[rnd3]) {
			rnd7 = Math.random() * nm15.length | 0;
		}
		if (nTp === 4) {
			result = nm12[rnd] + nm13[rnd2] + nm14[rnd4] + nm4[rnd5] + nm15[rnd7] + nm13[rnd6] + nm16[rnd3];
		} else {
			result = nm12[rnd] + nm13[rnd2] + nm15[rnd7] + nm4[rnd5] + nm14[rnd4] + nm13[rnd6] + nm16[rnd3];
		}
	}
	return result.substr(0, 1).toLocaleUpperCase() + result.substr(1);
}

for(let i = 0; i < 10; i++) {
    console.log(nameNeut());
    console.log(nameFem());
    console.log(nameMas());
}
