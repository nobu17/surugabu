import SimpleMDE from 'simplemde'

$(document).on("turbolinks:load", function () {

  // markdown editor activate
  console.log("editor")
  const simplemde = new SimpleMDE({ element: document.getElementById("editor") });

  // add image preview display change function 
  $("#article_title_image").on("change", function (e) {
    const files = e.target.files;
    let d = new $.Deferred().resolve();
    $.each(files, function (i, file) {
      d = d.then(function () {
        return previewImage(file);
      });
    });
  });

  const previewImage = function (imageFile) {
    const reader = new FileReader();
    const img = new Image();
    const def = $.Deferred();
    reader.onload = function (e) {
      // 画像を表示
      $("#image_preview").empty();
      $("#image_preview").append(img);
      img.src = e.target.result;
      def.resolve(img);
    };
    reader.readAsDataURL(imageFile);
    return def.promise();
  };
});
