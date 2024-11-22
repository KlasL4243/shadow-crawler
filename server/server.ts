import { initializeApp, cert } from 'firebase-admin/app';
import { getMessaging } from 'firebase-admin/messaging';

const app = initializeApp({ credential: cert("./serviceAccountKey.json") });
const messaging = getMessaging(app);

const message = {
    notification: {
        title: "Shadow Notification!",
        body: "Send by Node"
    },
    topic: "all"
}

await messaging.send(message)
    .then((response) => { console.log(`success: ${response}`) })
    .catch((error) => { console.log(error) });
