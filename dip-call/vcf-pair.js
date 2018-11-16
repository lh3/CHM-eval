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

var c, is_female = false, full_phase = false;
while ((c = getopt(arguments, "ft")) != null)
	if (c == 'f') is_female = true;
	else if (c == 't') full_phase = true;

if (getopt.ind == arguments.length) {
	print("Usage: vcf-pair.js [options] <in.pair.vcf>");
	print("Options: -f     the sample is female (ignoring chrY)");
	print("         -t     trio phasing; first is father; second is mother");
	exit(1);
}

var re_ctg = is_female? /^(chr)?([0-9]+|X)$/ : /^(chr)?([0-9]+|X|Y)$/;
var label = ['1', '2'];
var buf = new Bytes();
var file = arguments[getopt.ind] == '-'? new File() : new File(arguments[getopt.ind]);
while (file.readline(buf) >= 0) {
	var m, line = buf.toString();
	if (line.charAt(0) == '#') {
		if (/^##(source|reference)=/.test(line)) continue;
		if ((m = /^##contig=.*ID=([^\s,]+)/.exec(line)) != null) {
			if (!re_ctg.test(m[1])) continue;
		} else if (/^#CHROM/.test(line)) {
			var t = line.split("\t");
			--t.length;
			t[t.length-1] = 'syndip';
			line = t.join("\t");
			print('##FILTER=<ID=HET1,Description="Heterozygous in the first haplotype">');
			print('##FILTER=<ID=HET2,Description="Heterozygous in the second haplotype">');
			print('##FILTER=<ID=GAP1,Description="Uncalled in the first haplotype">');
			print('##FILTER=<ID=GAP2,Description="Uncalled in the second haplotype">');
		}
		print(line);
		continue;
	}
	var t = line.split("\t");
	if (!re_ctg.test(t[0])) continue;
	var GT = null, AD = null, FILTER = [], HT = [null, null];
	for (var i = 0; i < 2; ++i) {
		if ((m = /^(\.|[0-9]+)\/(\.|[0-9]+):(\S+)/.exec(t[9+i])) == null) throw Error("malformatted VCF");
		var s = m[3].split(",");
		if (AD == null) {
			AD = [];
			for (var j = 0; j < s.length; ++j)
				AD[j] = 0;
		}
		for (var j = 0; j < s.length; ++j)
			AD[j] += parseInt(s[j]);
		if (m[1] == '.') {
			FILTER.push('GAP' + label[i]);
			HT[i] = '.';
		} else if (m[1] != m[2]) {
			FILTER.push('HET' + label[i]);
			HT[i] = '.';
		} else HT[i] = m[1];
	}
	--t.length;
	// special treatment for male
	if (!is_female && FILTER.length == 1) {
		if (full_phase) {
			if ((/^(chr)?X/.test(t[0]) && FILTER[0] == "GAP1") || (/^(chr)?Y/.test(t[0]) && FILTER[0] == "GAP2"))
				FILTER.length = 0;
		} else {
			if (/^(chr)?[XY]/.test(t[0]) && /^GAP[12]$/.test(FILTER[0]))
				FILTER.length = 0;
		}
	}
	// update VCF
	t[5] = 30; // fake QUAL
	t[6] = FILTER.length? FILTER.join(";") : ".";
	t[9] = HT.join("|") + ":" + AD.join(",");
	print(t.join("\t"));
}
file.close();
buf.destroy();
