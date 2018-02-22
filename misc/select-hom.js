#!/usr/bin/env k8

var max_ref = 10, max_ref_ratio = 0.2, min_alt_sum = 5, size = 10;

if (arguments.length == 0) {
	print("select-hom.js <in.vcf>");
	exit(1);
}

var file = new File(arguments[0]);
var buf = new Bytes();

while (file.readline(buf) >= 0) {
	var line = buf.toString();
	var m, t = line.split("\t");
	if (t[0].charAt(0) == '#') continue;
	if ((m = /^(\d+)\/(\d+):(\S+)/.exec(t[9])) == null) continue;
	var s = m[3].split(",");
	if (s.length > 2) continue;
	var sum = 0;
	for (var i = 0; i < s.length; ++i) {
		s[i] = parseInt(s[i]);
		sum += s[i];
	}
	if (s[0] > max_ref || s[0] / sum > max_ref_ratio) continue;
	if (sum - s[0] < min_alt_sum) continue;
	var pos = parseInt(t[1]);
//	print(line);
	var st = pos < size? 0 : pos - size;
	print(t[0], st, pos + t[3].length + size);
}

buf.destroy();
file.close();
