import SimpleMDE from "simplemde";
import Rails from "@rails/ujs";
import marked from "marked";

let simplemde;

window.onload = function () {
  loadMDE();
  addImagePreviewEvent();
  loadPreview();
};

function loadMDE() {
  const editor = document.getElementById("editor");
  if (!simplemde && editor) {
    simplemde = new SimpleMDE({
      element: editor,
      spellChecker: false,
    });
    inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
      uploadUrl: "/adamin/article_edit/attach", // POSTする宛先Url
      uploadFieldName: "image", // ファイルのフィールド名(paramsで取り出す時のkey)
      allowedTypes: ["image/jpeg", "image/png", "image/jpg", "image/gif"],
      extraHeaders: { "X-CSRF-Token": Rails.csrfToken() }, // CSRF対策
      onFileUploadError: (response) => {
        alert("ファイルアップロード失敗。");
        console.log(response);
      },
    });
  }
}

function addImagePreviewEvent() {
  // add image preview display change function
  $("#article_title_image").on("change", function (e) {
    onChangeImage("#image_preview", e);
  });
  // add image preview display change function
  $("#article_content_images").on("change", function (e) {
    onChangeImage("#image_previews", e);
  });

  const onChangeImage = function (previewArea, e) {
    // reset preview area
    $(previewArea).empty();
    const files = e.target.files;
    let d = new $.Deferred().resolve();
    $.each(files, function (i, file) {
      d = d.then(function () {
        return previewImage(previewArea, file);
      });
    });
    // to detect change event everytime
    $(previewArea).val("");
  };

  const previewImage = function (previewArea, imageFile) {
    const reader = new FileReader();
    const img = new Image();
    const def = $.Deferred();
    reader.onload = function (e) {
      $(previewArea).append(img);
      img.src = e.target.result;
      def.resolve(img);
    };
    reader.readAsDataURL(imageFile);
    return def.promise();
  };
}


function loadPreview() {
  document.getElementById("preview-button").onclick = function(){
    previewMarkdown();
  }
}

function previewMarkdown() {
  const renderer = new marked.Renderer();
  marked.setOptions({ breaks: true, renderer: renderer });
  renderer.image = function (href, title, text) {
    if (href === null) {
      return text;
    }
    // FIXME: title, text
    return ` <div align="center"><img src="${href}" loading="lazy"></div>`;
  };
  const markDown = simplemde.value();
  const displayArea = document.getElementById("preview_area");
  if (displayArea) {
    const str = marked(markDown);
    displayArea.setAttribute("class", "art-p mt-2 markdown-body");
    displayArea.innerHTML = str;
  }
}