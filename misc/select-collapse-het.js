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

function main(args) {
	var c, cov = 22, min_len = 1000000, ratio = 0.75;
	while ((c = getopt(args, "c:l:r:")) != null) {
		if (c == 'c') cov = parseFloat(getopt.arg);
		else if (c == 'l') min_len = parseInt(getopt.arg);
		else if (c == 'r') ratio = parseFloat(getopt.arg);
	}
	if (args.length - getopt.ind == 0) {
		print("Usage: select-collapse-het.js [-c " + cov + "] in.vcf");
		return;
	}

	var min_cnt = cov * ratio;
	var lens = {}
	var buf = new Bytes();
	var file = new File(args[getopt.ind]);
	while (file.readline(buf) >= 0) {
		var line = buf.toString();
		var m, t = line.split("\t");
		if (t[0][0] == '#') {
			if ((m = /^##contig=<ID=([^\s,]+),\s*length=(\d+)/.exec(line)) != null)
				lens[m[1]] = parseInt(m[2]);
			continue;
		}
		if (lens[t[0]] == null || lens[t[0]] < min_len) continue;
		if (t[3].length != 1 || t[4].length != 1) continue;
		if ((m = /(\d+),(\d+)$/.exec(t[9])) == null) continue;
		var c0 = parseInt(m[1]), c1 = parseInt(m[2]);
		if (c0 < min_cnt || c1 < min_cnt) continue;
		print(line);
	}
	file.close();
	buf.destroy();
}

main(arguments);
