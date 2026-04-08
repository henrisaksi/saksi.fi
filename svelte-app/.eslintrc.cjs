/** @type {import('eslint').Linter.Config} */
const config = {
	root: true,
	env: {
		browser: true,
		es2017: true,
		node: true
	},
	extends: [
		'eslint:recommended',
		'plugin:@typescript-eslint/recommended',
		'plugin:svelte/recommended',
		'prettier'
	],
	parser: '@typescript-eslint/parser',
	parserOptions: {
		ecmaVersion: 2017,
		sourceType: 'module',
		extraFileExtensions: ['.svelte'],
		project: ['./tsconfig.json']
	},
	overrides: [
		{
			files: ['.*.svelte'],
			parser: 'svelte-eslint-parser',
			parserOptions: {
				parser: '@typescript-eslint/parser'
			}
		}
	],
	plugins: ['@typescript-eslint'],
	rules: {
		// Add any custom rules here
	}
};

module.exports = config;
