import type { Actions } from './$types';
import { PubSub } from '@google-cloud/pubsub';
import { dev } from '$app/environment';

export const actions = {
	submitMessage: async ({ request }) => {
		const data = await request.formData();
		const message = data.get('message');
		const email = data.get('email');

		if (dev) {
			console.log(JSON.stringify({ email, message }));
		} else {
			const pubSubClient = new PubSub();
			const topicName = 'contact-form-submission';
			const dataBuffer = Buffer.from(JSON.stringify({ email, message }));

			try {
				const messageId = await pubSubClient.topic(topicName).publishMessage({ data: dataBuffer });
				console.log(`Message ${messageId} published to ${topicName}`);
			} catch (error) {
				console.error(`Received error while publishing: ${(error as Error).message}`);
				// Consider whether to fail the request or just log the error
				// return fail(500, { error: 'Failed to send message' });
			}
		}

		return { success: true };
	}
} satisfies Actions;
