import SimpleMDE from "simplemde";

$(document).on("turbolinks:load", function () {
  console.log("load");
  // markdown editor activate
  const simplemde = new SimpleMDE({
    element: document.getElementById("editor"),
  });

  // add image preview display change function
  $("#article_title_image").on("change", function (e) {
    console.log("change");
    // reset preview area
    onChangeImage("#image_preview", e);
  });
  // add image preview display change function
  $("#article_content_images").on("change", function (e) {
    console.log("change2");
    // reset preview area
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
