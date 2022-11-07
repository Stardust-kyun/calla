/*
var d = new Date();
var n = d.toLocaleString([], {
  hour: "2-digit",
  minute: "2-digit",
  timezone: "IST",
});

document.getElementById("time").innerHTML = n;
*/
function updateClock() {
	var d = new Date();
	var n = d.toLocaleTimeString([], {
		hour: "2-digit",
		minute: "2-digit",
		// second: "2-digit",
		timezone: "IST",
	});
	document.getElementById("time").innerHTML = n; 
}
updateClock();
setInterval(updateClock, 1000);
