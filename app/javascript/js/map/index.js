import Rails from "@rails/ujs";

const article_url = "https://" + location.hostname + "/articles/";
let map;

window.onload = async () => {
  try {
    map = getMap();
    const mapTab = document.getElementById("map-tab");
    const data = await loadMapData();
    initMap(data);
    // only map tab not existed case
    if (!mapTab) {
      displayMap();
    } else {
      const observer = new MutationObserver(function () {        
        if (mapTab.style.display != "none") {
          setTimeout(() => {
            // map.invalidateSize();
            displayMap();
            map.invalidateSize();
          }, 500);
        }
      });
      observer.observe(mapTab, { attributes: true });
    }
  } catch (e) {
    console.error(e);
    displayError();
  }
};

async function loadMapData() {
  const url = "https://" + location.hostname + "/map/all"
  const res = await fetch(url, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": Rails.csrfToken(),
    },
  });
  const data = await res.json();
  // console.log(data);
  const sortedData = groupByCategory(data.data);
  // console.log(sortedData);
  return sortedData;
}

function initMap(markerData) {
  // let map = getMap();
  //座標の指定
  let mpoint = [35.12343, 138.927479];
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
  let sucontents = `<a target="_blank" rel="noopener noreferrer" href="${article_url}${placeData.id}"><h5>${placeData.title}</h5></a>`;
  sucontents += `<a target="_blank" rel="noopener noreferrer" href="${article_url}${placeData.id}"><p>${placeData.sub_title}</p></a>`;
  sucontents += `<a target="_blank" rel="noopener noreferrer" href="${article_url}${placeData.id}"><img src="${placeData.title_image_compressed_url}" width="200"></img></a>`;
  //ポップアップオブジェクトを作成
  const popup1 = L.popup({ maxWidth: 250 }).setContent(sucontents);
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

function getMap() {
  return L.map("mapcontainer", { zoomControl: true });
}
