// firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyCTzuq7-2NRP6NJ0YYxFQXv1LaqRPnbqQc",
    authDomain: "devin-hrms.firebaseapp.com",
    projectId: "devin-hrms",
    storageBucket: "devin-hrms.firebasestorage.app",
    messagingSenderId: "871586996697",
    appId: "1:871586996697:web:bd6445f3f9ec09fd4d79c8",
    measurementId: "G-DZT1Y5V342"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((message) => {
  console.log('[firebase-messaging-sw.js] Received background message ', message);
  const notificationTitle = message.notification.title;
  const notificationOptions = {
    body: message.notification.body,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
