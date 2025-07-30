const {onCall} = require('firebase-functions/v2/https');
const {onDocumentCreated} = require('firebase-functions/v2/firestore');
const {setGlobalOptions} = require('firebase-functions/v2');
const admin = require('firebase-admin');

admin.initializeApp();

setGlobalOptions({
  region: 'us-central1',
  maxInstances: 10,
  memory: '256MiB',
  timeoutSeconds: 60,
});

exports.sendNotification = onCall(
    {
      cors: true,
      enforceAppCheck: false,
    },
    async (request) => {
      const {title, body, token} = request.data;
      const message = {
        notification: {title, body},
        token,
      };

      try {
        const response = await admin.messaging().send(message);
        console.log('Notification sent:', response);
        return {success: true, response};
      } catch (error) {
        console.error('Error sending notification:', error);
        return {success: false, error: error.message};
      }
    },
);

exports.sendOnCreate = onDocumentCreated(
    {
      document: 'tasks/{taskId}',
      memory: '256MiB',
    },
    async (event) => {
      const data = event.data.data();
      const token = data.token;
      const title = 'New Task Created';
      const body = 'A new task has been added to your list.';
      console.log('Document created:', data);

      if (!token) {
        console.error('Missing fields');
        return;
      }

      const message = {
        notification: {title, body},
        token: token,
        data: {
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
          screen: '/home_screen',
          id: event.params.taskId,
        },
      };

      try {
        const response = await admin.messaging().send(message);
        console.log('Notification sent:', response);
      } catch (error) {
        console.error('Error sending notification:', error);
      }
    },
);
