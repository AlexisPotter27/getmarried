importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.15.5/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;


firebase.initializeApp({
  apiKey: "AIzaSyC_5URMdLBdsUg94va6SV_7I3UAja6Hfyo",
  authDomain: "getmarriedapp-810aa.firebaseapp.com",
  databaseURL: "https://getmarriedapp-810aa-default-rtdb.firebaseio.com",
  projectId: "getmarriedapp-810aa",
  storageBucket: "getmarriedapp-810aa.appspot.com",
  messagingSenderId: "594283361767",
  appId: "1:594283361767:web:5ef1002487251ef5e17942",
  measurementId: "G-DFC7KJDMMF"
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});