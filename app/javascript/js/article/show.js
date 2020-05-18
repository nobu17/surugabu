import marked from "marked";

window.onload = function () {
  loadMD();
};

function loadMD() {
  marked.setOptions({ breaks: true });
  const area = document.getElementById("article_content");
  if (area) {
    const str = marked(area.innerText);
    const displayArea = document.getElementById("actual_content");
    if (displayArea) {
      displayArea.setAttribute("class", "art-p mt-2 markdown-body");
      displayArea.innerHTML = str;
    }
  }
}
