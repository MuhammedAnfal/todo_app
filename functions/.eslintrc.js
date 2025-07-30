module.exports = {
  root: true,
  env: {
    node: true,
    es2021: true,
  },
  extends: ['eslint:recommended', 'google'],
  plugins: ['import'],
  rules: {
    'no-console': 'off',
    'import/no-unresolved': 'off', // temporarily disable this rule
  },
};
