import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = () => {
	// Permanently redirect all unknown GET requests to the home page (301)
	throw redirect(301, '/');
};
