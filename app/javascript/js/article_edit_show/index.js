
function openTwitter(article_id) {
    alert(article_id)
    const my_url = "https://" + window.location.host + "/articles/" + article_id
    const comment = "記事を投稿しました。#駿河部 #沼津" + my_url

    url = "http://twitter.com/share?url=" + escape(my_url) + "&text=" + comment;
    window.open(url,"_blank","width=600,height=300");
}
