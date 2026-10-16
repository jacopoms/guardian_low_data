// Guardian Low Data service worker.
// App-shell + content caching tuned for low data usage.
var CACHE_VERSION = 'v1';
var STATIC_CACHE = 'gld-static-' + CACHE_VERSION;
var PAGES_CACHE = 'gld-pages-' + CACHE_VERSION;

var APP_SHELL = [
  '/',
  '/offline.html',
  '/app.css',
  '/app.js',
  '/manifest.webmanifest',
  '/icons/icon-192.png',
  '/icons/icon-512.png',
  '/icons/maskable-512.png',
  '/icons/apple-touch-icon-180.png'
];

self.addEventListener('install', function (event) {
  event.waitUntil(
    caches.open(STATIC_CACHE).then(function (cache) {
      return cache.addAll(APP_SHELL);
    }).then(function () {
      return self.skipWaiting();
    })
  );
});

self.addEventListener('activate', function (event) {
  var expected = [STATIC_CACHE, PAGES_CACHE];
  event.waitUntil(
    caches.keys().then(function (keys) {
      return Promise.all(keys.map(function (key) {
        if (expected.indexOf(key) === -1) return caches.delete(key);
        return undefined;
      }));
    }).then(function () {
      return self.clients.claim();
    })
  );
});

function isStaticAsset(url) {
  return (
    url.pathname === '/app.css' ||
    url.pathname === '/app.js' ||
    url.pathname === '/offline.html' ||
    url.pathname === '/manifest.webmanifest' ||
    url.pathname.indexOf('/icons/') === 0
  );
}

// Navigations: network-first, fall back to cache, then offline page.
// Static assets: cache-first, update cache in background.
self.addEventListener('fetch', function (event) {
  var request = event.request;
  if (request.method !== 'GET') return;

  var url = new URL(request.url);
  if (url.origin !== self.location.origin) return;

  if (isStaticAsset(url)) {
    event.respondWith(
      caches.match(request, { ignoreSearch: true }).then(function (cached) {
        var network = fetch(request).then(function (response) {
          if (response && response.ok) {
            var copy = response.clone();
            caches.open(STATIC_CACHE).then(function (cache) {
              cache.put(request, copy);
            });
          }
          return response;
        }).catch(function () { return cached; });
        return cached || network;
      })
    );
    return;
  }

  // HTML navigations and API-backed pages (/, /page/:n, /article/*, /search?q=)
  if (request.mode === 'navigate' ||
      request.headers.get('Accept') && request.headers.get('Accept').indexOf('text/html') !== -1) {
    event.respondWith(
      fetch(request).then(function (response) {
        if (response && response.ok) {
          var copy = response.clone();
          caches.open(PAGES_CACHE).then(function (cache) {
            cache.put(request, copy);
          });
        }
        return response;
      }).catch(function () {
        return caches.match(request).then(function (cached) {
          return cached || caches.match('/offline.html');
        });
      })
    );
  }
});
