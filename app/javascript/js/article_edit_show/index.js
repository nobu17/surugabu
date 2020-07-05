window.onload = function () {
  loadButtonEvents();
};

function loadButtonEvents() {
  const btns = document.getElementsByClassName("twitter_btn");
  for (const btn of btns) {
    btn.onclick = function () {
      console.log("btn", btn);
      openTwitter(btn.id, btn.value);
    };
  }
}

function openTwitter(article_id, add_comment) {
  const tag = "駿河部,沼津市,富士市";
  const my_url = "https://" + window.location.host + "/articles/" + article_id;
  const comment = "記事を投稿しました。 " + add_comment;

  url =
    "http://twitter.com/share?url=" +
    escape(my_url) +
    "&text=" +
    comment +
    "&hashtags=" +
    tag;
  window.open(url, "_blank");
}
