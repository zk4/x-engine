function fontSizeInit() {
	var doc = document.documentElement,
	cli = doc.clientWidth,
	clh = doc.clientHeight;
	if(cli < clh){
		if (cli < 750) {
			cli = cli / 7.5;
		}else{
			cli = 100;
		}
		// cli = cli / 9;
	}else{
		if (clh < 750) {
			cli = clh / 7.5;
		} else {
			cli = 100;
		}
	}
	doc.style.fontSize = cli + "px";
}
fontSizeInit();