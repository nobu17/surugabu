import marked from "marked";

window.onload = function () {
  loadMD();
};

function loadMD() {
  const renderer = new marked.Renderer();
  marked.setOptions({ breaks: true, renderer: renderer });
  renderer.image = function (href, title, text) {
    if (href === null) {
      return text;
    }
    // FIXME: title, text
    return ` <div align="center"><img src="${href}" loading="lazy"></div>`;
  };
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
