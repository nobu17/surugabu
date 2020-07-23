import Rails from "@rails/ujs";

window.onload = async () => {
  try {
    const data = await loadMapData();
    initMap(data);
    displayMap();
  } catch (e) {
    console.error(e);
    displayError();
  }
};

async function loadMapData() {
  const res = await fetch("map/all", {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": Rails.csrfToken(),
    },
  });
  const data = await res.json();
  console.log(data);
  const sortedData = groupByCategory(data.data);
  console.log(sortedData);
  return sortedData;
}

function initMap(markerData) {
  var map = L.map("mapcontainer", { zoomControl: true });
  //座標の指定
  var mpoint = [35.12343, 138.927479];
  if (
    navigator.userAgent.indexOf("iPhone") > 0 ||
    navigator.userAgent.indexOf("iPod") > 0 ||
    navigator.userAgent.indexOf("Android") > 0
  ) {
    map.setView(mpoint, 9);
  } else {
    map.setView(mpoint, 11);
  }

  L.tileLayer("http://cyberjapandata.gsi.go.jp/xyz/pale/{z}/{x}/{y}.png", {
    attribution:
      "<a href='http://portal.cyberjapan.jp/help/termsofuse.html' target='_blank'></a>",
  }).addTo(map);

  addMakerByGroup(map, markerData);
}

function addMakerByGroup(map, categoryList) {
  let allLayers = {};
  Object.keys(categoryList).forEach((categoryKey) => {
    const markers = L.featureGroup();
    categoryList[categoryKey].forEach((value) => {
      markers.addLayer(getMarker(value));
    });
    allLayers[categoryKey] = markers;
    map.addLayer(markers);
  });
  L.control.layers(null, allLayers).addTo(map);
}

function getMarker(placeData) {
  let sucontents = `<h4>${placeData.title}</h4><p>${placeData.sub_title}</p></br>`;
  sucontents += `<img src="${placeData.title_image_compressed_url}"></img>`;
  //ポップアップオブジェクトを作成
  const popup1 = L.popup({ maxWidth: 850 }).setContent(sucontents);
  //マーカーにポップアップを紐付けする。同時にbindTooltipでツールチップも追加
  return L.marker([placeData.latitude, placeData.longitude], {
    draggable: false,
  }).bindPopup(popup1);
}

function displayMap() {
  document.getElementById("loader-container").style.display = "none";
  document.getElementById("mapcontainer").style.visibility = "visible";
}

function displayError() {
  document.getElementById("loader-container").style.display = "none";
  document.getElementById("mapcontainer").style.visibility = "hidden";
  document.getElementById("map-error").style.display = "inline";
}

function groupByCategory(data) {
  return data.reduce((rv, x) => {
    x.category = x.categorys[0];
    if (!rv[x.category.name]) {
      rv[x.category.name] = [];
    }
    rv[x.category.name].push(x);
    return rv;
  }, {});
}
