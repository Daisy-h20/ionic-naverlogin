import { registerPlugin } from '@capacitor/core';

import type { naverLoginPlugin } from './definitions';

const naverLogin = registerPlugin<naverLoginPlugin>('naverLogin', {
  web: () => import('./web').then(m => new m.naverLoginWeb()),
});

export * from './definitions';
export { naverLogin };
