#!/usr/bin/env k8

var dist = 10000, min_cnt = 9, max_dp = 50, size = 10, max_ins_dist = 5;

var file = new File(arguments[0]);
var buf = new Bytes();
var a = [], last_ins1 = null;
while (file.readline(buf) >= 0) {
	var line = buf.toString();
	if (line.charAt(0) == '#') continue;
	var t = line.split("\t");
	var pos = parseInt(t[1]) - 1;
	var m, type = null;
	if (t[3].length != 1) {
		type = false;
	} else if ((m = /^(\d+)\/(\d+):(\S+)/.exec(t[9])) != null) {
		var s = m[3].split(",");
		var a1 = parseInt(m[1]), a2 = parseInt(m[2]);
		var c1 = parseInt(s[a1]), c2 = parseInt(s[a2]);
		if (a1 == a2) { // a hom
			type = false;
		} else if (c1 + c2 > max_dp) {
			type = false;
		} else if (c1 < min_cnt || c2 < min_cnt) { // not enough supporting reads
			type = false;
		} else if (t[4].length == 2) { // 1bp insertion
			if (last_ins1 != null && last_ins1[0] == t[0] && pos - last_ins1[1] <= max_ins_dist)
				type = true;
			last_ins1 = [t[0], pos];
		} else if (t[4].length != 1 && !/^[A-Za-z]{2},[A-Za-z]{2}$/.test(t[4])) { // not a het or a insertion
			type = false;
		} else type = true;
	} else type = false;
	if (type == true) {
		var out = true;
		if (a.length > 0) {
			for (var i = a.length - 1; i >= 0; --i) {
				if (a[i][0] == t[0] && pos - a[i][1] < dist)
					a[i][2] = false, out = false;
				else break;
			}
		}
		a.push([t[0], pos, out, line]);
	}
}
buf.destroy();
file.close();

for (var i = 0; i < a.length; ++i) {
	if (a[i][2]) {
		//print(a[i][3]);
		var st = a[i][1] < size? 0 : a[i][1] - size;
		print(a[i][0], st, a[i][1] + 1 + size);
	}
}
