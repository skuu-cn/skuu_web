// // 防止浏览器后退
// window.history.pushState(null, null, window.location.href);
// window.onpopstate = function () {
//     window.history.pushState(null, null, window.location.href);
// };
//
// // 暴露一个函数给 Dart 调用
// function disableBackNavigation() {
//     window.history.pushState(null, null, window.location.href);
//     window.onpopstate = function () {
//         window.history.pushState(null, null, window.location.href);
//     };
// }


//防止页面后退
function disableBackNavigation() {
    history.pushState(null, null, document.URL);
    window.addEventListener('popstate', function () {
        history.pushState(null, null, document.URL);
    });
}
