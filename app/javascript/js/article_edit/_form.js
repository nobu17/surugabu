import SimpleMDE from "simplemde";

let simplemde;

window.onload = function() {
  console.log("load");
  const editor = document.getElementById("editor");
  if (!simplemde && editor) {
    console.log("add");
    simplemde = new SimpleMDE({
      element: editor,
    });
  }

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

$(document).on("render", function () {
  // markdown editor activate
  console.log("render");
});

$(document).on("load", function () {
  // markdown editor activate
  alert("load");
  console.log("load");
  editor = document.getElementById("editor");
  if (!simplemde && editor) {
    console.log("add");
    simplemde = new SimpleMDE({
      element: editor,
    });
  }

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
});
