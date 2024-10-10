import { registerPlugin } from '@capacitor/core';
const naverLogin = registerPlugin('naverLogin', {
    web: () => import('./web').then(m => new m.naverLoginWeb()),
});
export * from './definitions';
export { naverLogin };
//# sourceMappingURL=index.js.map