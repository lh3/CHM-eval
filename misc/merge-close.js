#!/usr/bin/env k8

var s = 10;

var f = new File();
var b = new Bytes();

var last_chr = null, start = 0, end = 0;
while (f.readline(b) >= 0) {
	var t = b.toString().split("\t");
	t[1] = parseInt(t[1]);
	t[2] = parseInt(t[2]);
	if (t[0] != last_chr) {
		if (last_chr) print(last_chr, start, end);
		last_chr = t[0], start = t[1], end = t[2];
	} else if (t[1] - end > s) {
		print(last_chr, start, end);
		start = t[1], end = t[2];
	} else {
		end = end > t[2]? end : t[2];
	}
}
if (last_chr) print(last_chr, start, end);

b.destroy();
f.close();
