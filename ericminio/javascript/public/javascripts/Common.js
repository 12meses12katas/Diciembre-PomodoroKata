function element(id) {
	return document.getElementById(id);
}

function remove(id) {
  var target = element(id);
  target.parentNode.removeChild(target);
};