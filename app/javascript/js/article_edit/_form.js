import SimpleMDE from "simplemde";
import Rails from "@rails/ujs";

let simplemde;

window.onload = function () {
  loadMDE();
  addImagePreviewEvent();
};

function loadMDE() {
  const editor = document.getElementById("editor");
  if (!simplemde && editor) {
    simplemde = new SimpleMDE({
      element: editor,
      spellChecker: false
    });
    inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
      uploadUrl: "/adamin/article_edit/attach", // POSTする宛先Url
      uploadFieldName: "image", // ファイルのフィールド名(paramsで取り出す時のkey)
      allowedTypes: ["image/jpeg", "image/png", "image/jpg", "image/gif"],
      extraHeaders: { "X-CSRF-Token": Rails.csrfToken() }, // CSRF対策
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
