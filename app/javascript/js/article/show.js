import marked from "marked";
import Rails from "@rails/ujs";

window.onload = function () {
  loadMD();
  incrementAccessCount();
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

function incrementAccessCount() {
  const articleid = location.pathname.split("/").pop();
  if (isNaN(articleid)) {
    console.error("param error", articleid);
    return;
  }
  $.ajax({
    url: "/article_access_count/" + articleid,
    type: "PUT",
    headers: {
      "X-CSRF-Token": Rails.csrfToken(),
      "Cache-Control": "no-cache",
    },
    data: {},
  })
    .done((data) => {
      console.log("count up is finished");
    })
    .fail((err) => {
      console.error("count up is failed", err);
    });
}
