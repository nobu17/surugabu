window.onload = function () {
  loadButtonEvents();
};

function loadButtonEvents() {
  const btns = document.getElementsByClassName("twitter_btn");
  for (const btn of btns) {
    btn.onclick = function () {
      openTwitter(btn.id);
    };
  }
}

function openTwitter(article_id) {
  const tag = "駿河部,沼津";
  const my_url = "https://" + window.location.host + "/articles/" + article_id;
  const comment = "記事を投稿しました。 " + my_url;

  url =
    "http://twitter.com/share?url=" +
    escape(document.location.href) +
    "&text=" +
    comment +
    "&hashtags=" +
    tag;
  window.open(url, "_blank");
}
