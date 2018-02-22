#!/usr/bin/env k8

var getopt = function(args, ostr) {
	var oli; // option letter list index
	if (typeof(getopt.place) == 'undefined')
		getopt.ind = 0, getopt.arg = null, getopt.place = -1;
	if (getopt.place == -1) { // update scanning pointer
		if (getopt.ind >= args.length || args[getopt.ind].charAt(getopt.place = 0) != '-') {
			getopt.place = -1;
			return null;
		}
		if (getopt.place + 1 < args[getopt.ind].length && args[getopt.ind].charAt(++getopt.place) == '-') { // found "--"
			++getopt.ind;
			getopt.place = -1;
			return null;
		}
	}
	var optopt = args[getopt.ind].charAt(getopt.place++); // character checked for validity
	if (optopt == ':' || (oli = ostr.indexOf(optopt)) < 0) {
		if (optopt == '-') return null; //  if the user didn't specify '-' as an option, assume it means null.
		if (getopt.place < 0) ++getopt.ind;
		return '?';
	}
	if (oli+1 >= ostr.length || ostr.charAt(++oli) != ':') { // don't need argument
		getopt.arg = null;
		if (getopt.place < 0 || getopt.place >= args[getopt.ind].length) ++getopt.ind, getopt.place = -1;
	} else { // need an argument
		if (getopt.place >= 0 && getopt.place < args[getopt.ind].length)
			getopt.arg = args[getopt.ind].substr(getopt.place);
		else if (args.length <= ++getopt.ind) { // no arg
			getopt.place = -1;
			if (ostr.length > 0 && ostr.charAt(0) == ':') return ':';
			return '?';
		} else getopt.arg = args[getopt.ind]; // white space
		getopt.place = -1;
		++getopt.ind;
	}
	return optopt;
}

// parse command-line options
var c, w1 = 1000, w2 = 10000, min_n = 2, zero_start = false;
while ((c = getopt(arguments, "w:W:n:0")) != null) {
	if (c == 'w') w1 = parseInt(getopt.arg);
	else if (c == 'W') w2 = parseInt(getopt.arg);
	else if (c == 'n') min_n = parseInt(getopt.arg);
	else if (c == '0') zero_start = true;
}

// read data
var file = getopt.ind < arguments.length? new File(arguments[getopt.ind]) : new File();
var buf = new Bytes();
var seqs = {};
while (file.readline(buf) >= 0) {
	var t = buf.toString().split("\t");
	if (seqs[t[0]] == null) seqs[t[0]] = [];
	var x = parseInt(t[1]);
	if (zero_start) ++x;
	seqs[t[0]].push(x);
}
buf.destroy();
file.close();

// cluster
function cluster(a, w1, w2)
{
	a.sort(function(b,c){return b-c});
	var x = [], y = [];
	for (var i = 0; i < a.length; ++i)
		x.push([i, a[i] - 1, a[i], 1]);
	for (var i = 0; i < a.length - 1; ++i)
		y.push([a[i+1] - a[i], i]);

	y.sort(function(b,c){return b[0]!=c[0]?b[0]-c[0]:b[1]-c[1]});
	for (var j = 0; j < y.length && y[j][0] <= w2; ++j) {
		var l = y[j][1] + 1;
		if (x[l][0] != l)
			throw Error("Bug!!!");
		// find the parent of y[j][1]
		var k = y[j][1], tmp = [];
		while (x[k][0] != k)
			tmp.push((k = x[k][0]));
		for (var i = 0; i < tmp.length; ++i) x[tmp[i]][0] = k;
		// test merge
		if ((x[l][2] - x[k][1]) / (x[l][3] + x[k][3]) > w1) continue;
		// merge l into k
		x[k][2] = x[l][2]; x[k][3] += x[l][3];
		x[l][0] = k;
	}
	y.length = 0;
	return x;
}

for (var seq in seqs) {
	var x = cluster(seqs[seq], w1, w2);
	for (var i = 0; i < x.length; ++i)
		if (x[i][0] == i && x[i][3] >= min_n)
			print(seq, x[i][1], x[i][2], x[i][3]);
}
