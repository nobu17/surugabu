import marked from "marked";

window.onload = function () {
  loadMD();
};

function loadMD() {
  const area = document.getElementById("article_content");
  if (area) {
    const str = marked(area.innerText);
    const displayArea = document.getElementById("actual_content");
    if(displayArea) {
        displayArea.setAttribute("class", "art-p mt-2");
        displayArea.innerHTML = str;
    }
  }
}
