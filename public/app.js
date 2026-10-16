// Registers the service worker for PWA installability / offline support.
(function () {
  if (!('serviceWorker' in navigator)) return;
  window.addEventListener('load', function () {
    navigator.serviceWorker.register('/sw.js', { scope: '/' }).catch(function (err) {
      // Registration failure should never break the app.
      console.warn('Service worker registration failed:', err);
    });
  });
})();
